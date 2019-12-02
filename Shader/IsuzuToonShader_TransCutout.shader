// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "IsuzuToonShader/TransCutout"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[Header(Metallic)]_Metallic("Metallic", Range( 0 , 1)) = 0
		[NoScaleOffset][Header(Transparency)]_TransparentMask("Transparent Mask", 2D) = "white" {}
		_Transparency("Transparency", Range( 0 , 1)) = 0
		[Toggle(_TRANSPARENTISBASETEXTURE_ON)] _TransparentisBaseTexture("Transparent is Base Texture", Float) = 1
		[NoScaleOffset][Header(Base Map)]_MainTexure("Main Texure", 2D) = "white" {}
		_BaseColor("Base Color", Color) = (1,1,1,0)
		[NoScaleOffset][Header(Shadow Settings)]_1stShadeMap("1st Shade Map", 2D) = "white" {}
		_1stShadeColor("1st Shade Color", Color) = (0.8018868,0.8018868,0.8018868,0)
		[NoScaleOffset]_2ndShadeMap("2nd Shade Map", 2D) = "white" {}
		_2ndShadeColor("2nd Shade Color", Color) = (0.4811321,0.4811321,0.4811321,0)
		[Header(Toon Shade Settings)]_BaseColorStep("Base Color Step", Range( 0 , 1)) = 0
		_BaseShadeSoftness("Base Shade Softness", Range( 0 , 1)) = 0
		_ShadeColorStep("Shade Color Step", Range( 0 , 1)) = 0
		_1st2ndShadeSoftness("1st2nd Shade Softness", Range( 0 , 1)) = 0
		[Normal][Header(Normal Map)]_Normal("Normal", 2D) = "bump" {}
		_NormalScale("Normal Scale", Range( 0 , 10)) = 1
		[Header(Rim Light Settings)][Toggle(_USERIM_ON)] _UseRim("Use Rim", Float) = 0
		[Header(Rim Light)]_RimColor("Rim Color", Color) = (1,1,1,0)
		_RimLightMask("RimLight Mask", 2D) = "white" {}
		_RimPower("Rim Power", Range( 0 , 1)) = 0
		_RimOffset("Rim Offset", Range( 0 , 1)) = 0.1
		[Header(Subsurface)][Toggle(_USESUBSURFACE_ON)] _UseSubsurface("Use Subsurface", Float) = 0
		_SSSMap("SSS Map", 2D) = "white" {}
		_SSSMultiplier("SSS Multiplier", Float) = 1
		_SSSColor("SSS Color", Color) = (0,0,0,0)
		_SSSColorPower("SSS Color Power", Float) = 4
		_SSSScale("SSS Scale", Float) = 1
		_SSSPower("SSS Power", Float) = 1
		_ShadowStrength("Shadow Strength", Range( 0 , 1)) = 1
		_PointLightPunchthrough("Point Light Punchthrough", Range( 0 , 1)) = 0
		_SubsurfaceDistortion("Subsurface Distortion", Range( 0 , 1)) = 0.822
		[NoScaleOffset][Header(Matcap Settings)]_Matcap("Matcap", 2D) = "black" {}
		[NoScaleOffset]_MatcapMask("Matcap Mask", 2D) = "white" {}
		[NoScaleOffset][Header(Specular Map)]_SpecularMask("Specular Mask", 2D) = "white" {}
		_SpecularColor("Specular Color", Color) = (0,0,0,0)
		_SpecularSmoothness("Specular Smoothness", Range( 0 , 1)) = 0
		_SpecularPower("Specular Power", Range( 0 , 1)) = 0
		[NoScaleOffset][Header(Emmision Map)]_EmmissiveMask("Emmissive Mask", 2D) = "black" {}
		[HDR]_EmmisiveColor("Emmisive Color", Color) = (1,1,1,1)
		[Header(Light Settings)]_UnlitIntensity("Unlit Intensity", Range( 0.001 , 4)) = 1
		_MaskClipValue("Mask Clip Value", Range( 0 , 1)) = 0
		[NoScaleOffset][Header(Outline Settings)]_OutlineMask("Outline Mask", 2D) = "white" {}
		_OutlineColor("Outline Color", Color) = (0,0,0,0)
		_OutlineWidth("Outline Width", Range( 0 , 1)) = 0
		[IntRange][Header(Stencil Buffer)]_Reference("Reference", Range( 0 , 255)) = 0
		[IntRange]_ReadMask("Read Mask", Range( 0 , 255)) = 255
		[IntRange]_WriteMask("Write Mask", Range( 0 , 255)) = 255
		[Enum(UnityEngine.Rendering.CompareFunction)]_CompFront("Comp. Front", Int) = 8
		[Enum(UnityEngine.Rendering.StencilOp)]_PassFront("Pass Front", Int) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_FailFront("Fail Front", Int) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_ZFailFront("ZFail Front", Int) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_CompBack("Comp. Back", Int) = 8
		[Enum(UnityEngine.Rendering.StencilOp)]_PassBack("Pass Back", Int) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_FailBack("Fail Back", Int) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_ZFailBack("ZFail Back", Int) = 0
		[Enum(UnityEngine.Rendering.CullMode)][Header(Rendering)]_CullMode("Cull Mode", Int) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0"}
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_OutlineMask574 = v.texcoord;
			float4 tex2DNode574 = tex2Dlod( _OutlineMask, float4( uv_OutlineMask574, 0, 0.0) );
			float3 ase_vertexNormal = v.normal.xyz;
			float3 outlineVar = ( tex2DNode574.r * _OutlineWidth * 0.01 * ase_vertexNormal );
			v.vertex.xyz += outlineVar;
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float2 uv_OutlineMask574 = i.uv_texcoord;
			float4 tex2DNode574 = tex2D( _OutlineMask, uv_OutlineMask574 );
			float2 uv_TransparentMask2_g130 = i.uv_texcoord;
			float2 uv_MainTexure73_g1 = i.uv_texcoord;
			float4 tex2DNode73_g1 = tex2D( _MainTexure, uv_MainTexure73_g1 );
			float4 MainTexture327_g1 = tex2DNode73_g1;
			#ifdef _TRANSPARENTISBASETEXTURE_ON
				float staticSwitch3_g130 = MainTexture327_g1.a;
			#else
				float staticSwitch3_g130 = tex2D( _TransparentMask, uv_TransparentMask2_g130 ).r;
			#endif
			float temp_output_565_323 = staticSwitch3_g130;
			float ifLocalVar583 = 0;
			if( _OutlineWidth <= 0.0 )
				ifLocalVar583 = 0.001;
			else
				ifLocalVar583 = temp_output_565_323;
			o.Emission = ( _OutlineColor * tex2DNode574 ).rgb;
			clip( ifLocalVar583 - _Cutoff );
		}
		ENDCG
		

		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull [_CullMode]
		Stencil
		{
			Ref [_Reference]
			ReadMask [_ReadMask]
			WriteMask [_WriteMask]
			CompFront [_CompFront]
			PassFront [_PassFront]
			FailFront [_FailFront]
			ZFailFront [_ZFailFront]
			CompBack [_CompBack]
			PassBack [_PassBack]
			FailBack [_FailBack]
			ZFailBack [_ZFailBack]
		}
		Blend SrcAlpha OneMinusSrcAlpha , SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature _TRANSPARENTISBASETEXTURE_ON
		#pragma shader_feature _USERIM_ON
		#pragma shader_feature _USESUBSURFACE_ON
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
			half ASEVFace : VFACE;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float _WriteMask;
		uniform int _CullMode;
		uniform int _CompFront;
		uniform int _PassBack;
		uniform int _FailBack;
		uniform float _MaskClipValue;
		uniform int _PassFront;
		uniform float _Reference;
		uniform float _ReadMask;
		uniform int _FailFront;
		uniform int _ZFailFront;
		uniform int _ZFailBack;
		uniform int _CompBack;
		uniform sampler2D _EmmissiveMask;
		uniform float4 _EmmisiveColor;
		uniform sampler2D _TransparentMask;
		uniform sampler2D _MainTexure;
		uniform float _Transparency;
		uniform float4 _SpecularColor;
		uniform float _UnlitIntensity;
		uniform sampler2D _SpecularMask;
		uniform float _SpecularPower;
		uniform float _SpecularSmoothness;
		uniform float _NormalScale;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform sampler2D _2ndShadeMap;
		uniform float4 _2ndShadeColor;
		uniform sampler2D _1stShadeMap;
		uniform float4 _1stShadeColor;
		uniform float4 _BaseColor;
		uniform float _BaseColorStep;
		uniform float _BaseShadeSoftness;
		uniform float _ShadeColorStep;
		uniform float _1st2ndShadeSoftness;
		uniform sampler2D _RimLightMask;
		uniform float4 _RimLightMask_ST;
		uniform float _RimOffset;
		uniform float _RimPower;
		uniform float4 _RimColor;
		uniform sampler2D _Matcap;
		uniform sampler2D _MatcapMask;
		uniform float4 _SSSColor;
		uniform sampler2D _SSSMap;
		uniform float4 _SSSMap_ST;
		uniform float _SubsurfaceDistortion;
		uniform float _SSSPower;
		uniform float _SSSScale;
		uniform float _SSSMultiplier;
		uniform float _ShadowStrength;
		uniform float _PointLightPunchthrough;
		uniform float _SSSColorPower;
		uniform float _Metallic;
		uniform float _Cutoff = 0.5;
		uniform sampler2D _OutlineMask;
		uniform float _OutlineWidth;
		uniform float4 _OutlineColor;


		float3 False13_g152( float3 Normal )
		{
			return ShadeSH9(half4(Normal, 1.0));
		}


		float3 False8_g152( float3 Normal )
		{
			return ShadeSH9(half4(Normal, 1.0));
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += 0;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float2 uv_TransparentMask2_g130 = i.uv_texcoord;
			float2 uv_MainTexure73_g1 = i.uv_texcoord;
			float4 tex2DNode73_g1 = tex2D( _MainTexure, uv_MainTexure73_g1 );
			float4 MainTexture327_g1 = tex2DNode73_g1;
			#ifdef _TRANSPARENTISBASETEXTURE_ON
				float staticSwitch3_g130 = MainTexture327_g1.a;
			#else
				float staticSwitch3_g130 = tex2D( _TransparentMask, uv_TransparentMask2_g130 ).r;
			#endif
			float temp_output_565_323 = staticSwitch3_g130;
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 lerpResult6_g152 = lerp( ( ase_lightColor.rgb * ase_lightAtten ) , ase_lightColor.rgb , step( _WorldSpaceLightPos0.w , 0.0 ));
			float3 appendResult12_g152 = (float3(0.05 , 0.05 , 0.05));
			float3 Normal13_g152 = float3( 0,0,0 );
			float3 localFalse13_g152 = False13_g152( Normal13_g152 );
			float3 Normal8_g152 = float3(0,-1,0);
			float3 localFalse8_g152 = False8_g152( Normal8_g152 );
			float3 LightColor57_g1 = max( saturate( lerpResult6_g152 ) , saturate( max( ( appendResult12_g152 * _UnlitIntensity ) , ( _UnlitIntensity * max( localFalse13_g152 , localFalse8_g152 ) ) ) ) );
			float2 uv_SpecularMask19_g149 = i.uv_texcoord;
			float temp_output_47_0_g149 = ( 1.0 - pow( _SpecularPower , 5.0 ) );
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float3 NromalMap314_g1 = UnpackScaleNormal( tex2D( _Normal, uv_Normal ), _NormalScale );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 normalizeResult4_g150 = normalize( ( ase_worldViewDir + ase_worldlightDir ) );
			float dotResult11_g149 = dot( (WorldNormalVector( i , NromalMap314_g1 )) , normalizeResult4_g150 );
			float smoothstepResult59_g149 = smoothstep( temp_output_47_0_g149 , ( temp_output_47_0_g149 - _SpecularSmoothness ) , (dotResult11_g149*0.5 + 0.5));
			float2 uv_2ndShadeMap51_g1 = i.uv_texcoord;
			float4 SecondShadeColor96_g1 = ( ( tex2D( _2ndShadeMap, uv_2ndShadeMap51_g1 ) * ( tex2DNode73_g1 * _2ndShadeColor ) ) * float4( LightColor57_g1 , 0.0 ) );
			float2 uv_1stShadeMap61_g1 = i.uv_texcoord;
			float4 FirstShadeColor91_g1 = ( ( tex2D( _1stShadeMap, uv_1stShadeMap61_g1 ) * ( tex2DNode73_g1 * _1stShadeColor ) ) * float4( LightColor57_g1 , 0.0 ) );
			float4 BaseColor102_g1 = ( ( _BaseColor * tex2DNode73_g1 ) * float4( LightColor57_g1 , 0.0 ) );
			float dotResult30_g153 = dot( (WorldNormalVector( i , NromalMap314_g1 )) , ase_worldlightDir );
			float clampResult26_g153 = clamp( (ase_lightAtten*0.5 + 0.5) , 0.0001 , 1.0 );
			float temp_output_14_0_g153 = saturate( ase_lightColor.a );
			float4 lerpResult20_g153 = lerp( FirstShadeColor91_g1 , BaseColor102_g1 , ( 1.0 - saturate( ( (1.0 + ((dotResult30_g153*0.5 + 0.5) - ( _BaseColorStep - _BaseShadeSoftness )) * (0.0 - 1.0) / (_BaseColorStep - ( _BaseColorStep - _BaseShadeSoftness ))) * clampResult26_g153 * temp_output_14_0_g153 ) ) ));
			float4 lerpResult19_g153 = lerp( SecondShadeColor96_g1 , lerpResult20_g153 , ( 1.0 - saturate( ( clampResult26_g153 * (1.0 + ((dotResult30_g153*0.5 + 0.5) - ( _ShadeColorStep - _1st2ndShadeSoftness )) * (0.0 - 1.0) / (_ShadeColorStep - ( _ShadeColorStep - _1st2ndShadeSoftness ))) * temp_output_14_0_g153 ) ) ));
			float4 FinalBaseColor137_g1 = lerpResult19_g153;
			float4 SpecularColor189_g1 = ( ( _SpecularColor * float4( LightColor57_g1 , 0.0 ) * ( tex2D( _SpecularMask, uv_SpecularMask19_g149 ) * ( 1.0 - smoothstepResult59_g149 ) ) ) + FinalBaseColor137_g1 );
			float4 temp_output_31_0_g146 = SpecularColor189_g1;
			float temp_output_11_0_g146 = ( ( 1.0 - _WorldSpaceLightPos0.w ) + ( _WorldSpaceLightPos0.w * ase_lightAtten ) );
			float2 uv_RimLightMask = i.uv_texcoord * _RimLightMask_ST.xy + _RimLightMask_ST.zw;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float dotResult17_g146 = dot( ase_worldNormal , ase_worldViewDir );
			float4 temp_output_19_0_g146 = ( temp_output_11_0_g146 * tex2D( _RimLightMask, uv_RimLightMask ) * pow( ( 1.0 - saturate( ( dotResult17_g146 + _RimOffset ) ) ) , ( 1.0 - _RimPower ) ) );
			#ifdef _USERIM_ON
				float4 staticSwitch2_g146 = ( saturate( ( ( temp_output_31_0_g146 * temp_output_11_0_g146 ) - temp_output_19_0_g146 ) ) + ( temp_output_19_0_g146 * _RimColor ) );
			#else
				float4 staticSwitch2_g146 = temp_output_31_0_g146;
			#endif
			float4 RimLight215_g1 = staticSwitch2_g146;
			float2 uv_MatcapMask6_g148 = i.uv_texcoord;
			float4 Matcap218_g1 = ( tex2D( _Matcap, ((BlendNormals( ( mul( UNITY_MATRIX_V, float4( ase_worldViewDir , 0.0 ) ).xyz * float3(-1,-1,1) ) , mul( UNITY_MATRIX_V, float4( ase_worldNormal , 0.0 ) ).xyz )).xy*0.5 + 0.5) ) * tex2D( _MatcapMask, uv_MatcapMask6_g148 ) * float4( LightColor57_g1 , 0.0 ) );
			float2 uv_SSSMap = i.uv_texcoord * _SSSMap_ST.xy + _SSSMap_ST.zw;
			float dotResult11_g147 = dot( ase_worldViewDir , -( ase_worldlightDir + ( ase_worldNormal * _SubsurfaceDistortion ) ) );
			float dotResult13_g147 = dot( pow( ( ( dotResult11_g147 * ( 1.0 - _WorldSpaceLightPos0.w ) ) + ( _WorldSpaceLightPos0.w * ase_lightAtten ) ) , _SSSPower ) , _SSSScale );
			float temp_output_18_0_g147 = saturate( ( tex2D( _SSSMap, uv_SSSMap ).r * dotResult13_g147 * _SSSMultiplier ) );
			float temp_output_32_0_g147 = ( ( temp_output_18_0_g147 * saturate( ( ase_lightAtten + ( 1.0 - _ShadowStrength ) ) ) * ( 1.0 - _WorldSpaceLightPos0.w ) ) + ( ase_lightAtten * temp_output_18_0_g147 * _WorldSpaceLightPos0.w * _PointLightPunchthrough ) );
			float4 lerpResult26_g147 = lerp( _SSSColor , ase_lightColor , saturate( pow( temp_output_32_0_g147 , _SSSColorPower ) ));
			float4 switchResult52_g147 = (((i.ASEVFace>0)?(saturate( ( lerpResult26_g147 * saturate( ase_lightColor.a ) * temp_output_32_0_g147 ) )):(float4( 0,0,0,0 ))));
			#ifdef _USESUBSURFACE_ON
				float4 staticSwitch45_g147 = switchResult52_g147;
			#else
				float4 staticSwitch45_g147 = float4( 0,0,0,0 );
			#endif
			float4 SSS211_g1 = staticSwitch45_g147;
			Unity_GlossyEnvironmentData g8_g145 = UnityGlossyEnvironmentSetup( _Metallic, data.worldViewDir, ase_worldNormal, float3(0,0,0));
			float3 indirectSpecular8_g145 = UnityGI_IndirectSpecular( data, 1.0, ase_worldNormal, g8_g145 );
			float4 lerpResult425_g1 = lerp( ( RimLight215_g1 + Matcap218_g1 + SSS211_g1 ) , ( BaseColor102_g1 * float4( LightColor57_g1 , 0.0 ) * float4( indirectSpecular8_g145 , 0.0 ) ) , _Metallic);
			c.rgb = saturate( lerpResult425_g1 ).xyz;
			c.a = saturate( ( staticSwitch3_g130 + ( 1.0 - _Transparency ) ) );
			clip( temp_output_565_323 - _Cutoff );
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float2 uv_EmmissiveMask2_g151 = i.uv_texcoord;
			o.Emission = ( tex2D( _EmmissiveMask, uv_EmmissiveMask2_g151 ) * _EmmisiveColor ).rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "Shiranui_Isuzu.IsuzuToonShader.Inspector.IsuzuToonShaderInspector"
}
/*ASEBEGIN
Version=17400
2024;427;1906;889;-1500.851;-326.0953;1;True;True
Node;AmplifyShaderEditor.ColorNode;579;1785.109,549.1916;Float;False;Property;_OutlineColor;Outline Color;53;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;580;1978.726,551.3676;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;572;2126.534,867.0309;Float;False;Property;_OutlineWidth;Outline Width;54;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;576;2271.226,551.3676;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;575;2216.807,1053.993;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;577;2234.081,976.7006;Float;False;Constant;_Float1;Float 0;5;0;Create;True;0;0;False;0;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;565;2381.083,360.8887;Inherit;False;ShadeCore;1;;1;1d86b0e5f2bb83646b4b93539489b28b;0;0;5;COLOR;331;FLOAT;325;FLOAT;323;FLOAT4;0;COLOR;246
Node;AmplifyShaderEditor.CommentaryNode;530;2008.214,1527.081;Inherit;False;1190.854;946.5505;Comment;3;532;531;491;Master Node Output Options;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;574;1830.246,751.5519;Inherit;True;Property;_OutlineMask;Outline Mask;52;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Outline Settings);-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;587;2458.851,1046.595;Inherit;False;Constant;_Eps;Eps;26;0;Create;True;0;0;False;0;0.001;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;532;2034.692,1650.239;Inherit;False;232;165;Comment;1;533;Cull Mode;0.1172414,1,0,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;578;2654.928,621.4346;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;531;2295.275,1726.156;Inherit;False;408.8691;641.6335;Comment;11;550;549;547;545;543;542;541;538;537;535;534;Stencil Buffer;0.0147059,1,0.9184586,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;581;2432.115,777.8481;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ConditionalIfNode;583;2646.75,776.7293;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;550;2314.511,1846.368;Float;False;Property;_ReadMask;Read Mask;56;1;[IntRange];Create;True;0;0;True;0;255;255;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;543;2314.511,1766.368;Float;False;Property;_Reference;Reference;55;1;[IntRange];Create;True;0;0;True;1;Header(Stencil Buffer);0;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;547;2314.511,2086.369;Float;False;Property;_PassFront;Pass Front;59;1;[Enum];Create;True;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;534;2314.511,2166.369;Float;False;Property;_FailFront;Fail Front;60;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;537;2522.511,2006.368;Float;False;Property;_CompBack;Comp. Back;62;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;8;8;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;545;2522.511,2246.369;Float;False;Property;_ZFailBack;ZFail Back;65;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;538;2314.511,2246.369;Float;False;Property;_ZFailFront;ZFail Front;61;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;542;2314.511,2006.368;Float;False;Property;_CompFront;Comp. Front;58;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;8;8;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;533;2079.127,1700.139;Float;False;Property;_CullMode;Cull Mode;66;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;1;Header(Rendering);0;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;549;2314.511,1926.368;Float;False;Property;_WriteMask;Write Mask;57;1;[IntRange];Create;True;0;0;True;0;255;255;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;541;2522.511,2086.369;Float;False;Property;_PassBack;Pass Back;63;1;[Enum];Create;True;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;491;2031.586,1868.659;Float;False;Property;_MaskClipValue;Mask Clip Value;51;0;Create;True;0;0;True;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;535;2522.511,2166.369;Float;False;Property;_FailBack;Fail Back;64;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.OutlineNode;582;2821.36,651.5959;Inherit;False;2;True;Masked;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3104.161,202.1557;Float;False;True;-1;2;Shiranui_Isuzu.IsuzuToonShader.Inspector.IsuzuToonShaderInspector;0;0;CustomLighting;IsuzuToonShader/TransCutout;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;True;0;True;543;255;True;550;255;True;549;0;True;542;0;True;547;0;True;534;0;True;538;0;True;537;0;True;541;0;True;535;0;True;545;False;2;15;10;25;False;0.5;True;2;5;False;536;10;False;544;2;5;False;539;10;False;540;0;False;548;0;False;546;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;True;533;-1;0;False;491;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;580;0;579;0
WireConnection;576;0;580;0
WireConnection;578;0;576;0
WireConnection;578;1;574;0
WireConnection;581;0;574;1
WireConnection;581;1;572;0
WireConnection;581;2;577;0
WireConnection;581;3;575;0
WireConnection;583;0;572;0
WireConnection;583;2;565;323
WireConnection;583;3;587;0
WireConnection;583;4;587;0
WireConnection;582;0;578;0
WireConnection;582;2;583;0
WireConnection;582;1;581;0
WireConnection;0;2;565;331
WireConnection;0;9;565;325
WireConnection;0;10;565;323
WireConnection;0;13;565;0
WireConnection;0;11;582;0
ASEEND*/
//CHKSM=055602EAF6BA526E541FD9AE5277B2F07B37CA4D