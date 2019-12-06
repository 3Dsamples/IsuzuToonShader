// Copyright © 2019 shiranui_isuzu. All rights reserved.
// https://twitter.com/Shiranui_Isuzu_

using System;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Threading;
using NUnit.Framework;
using Shiranui_Isuzu.IsuzuToonShader.Utility;
using UnityEditor;
using UnityEngine;

namespace Shiranui_Isuzu.IsuzuToonShader.Inspector
{
    ///<inheritdoc />
    /// このクラスはShaderPropertyGeneratorにより
    /// 2019/11/27 20:33:04に自動生成されました。
    /// このファイルをエディタで直接編集しないでください。
    /// </summary>
    public class IsuzuToonShaderInspector : ShaderGUI
    {
        #region Fields

        private readonly string transparentMask = "_TransparentMask";
        private readonly string transparency = "_Transparency";
        private readonly string transparentisBaseTexture = "_TransparentisBaseTexture";
        private readonly string mainTexure = "_MainTexure";
        private readonly string baseColor = "_BaseColor";
        private readonly string stShadeMap = "_1stShadeMap";
        private readonly string stShadeColor = "_1stShadeColor";
        private readonly string ndShadeMap = "_2ndShadeMap";
        private readonly string ndShadeColor = "_2ndShadeColor";
        private readonly string baseColorStep = "_BaseColorStep";
        private readonly string baseShadeSoftness = "_BaseShadeSoftness";
        private readonly string shadeColorStep = "_ShadeColorStep";
        private readonly string st2ndShadeSoftness = "_1st2ndShadeSoftness";
        private readonly string normal = "_Normal";
        private readonly string normalScale = "_NormalScale";
        private readonly string useRim = "_UseRim";
        private readonly string rimColor = "_RimColor";
        private readonly string rimLightMask = "_RimLightMask";
        private readonly string rimPower = "_RimPower";
        private readonly string rimOffset = "_RimOffset";
        private readonly string rimBias = "_RimBias";
        private readonly string useSubsurface = "_UseSubsurface";
        private readonly string sSSMap = "_SSSMap";
        private readonly string sSSMultiplier = "_SSSMultiplier";
        private readonly string sSSColor = "_SSSColor";
        private readonly string sSSColorPower = "_SSSColorPower";
        private readonly string sSSScale = "_SSSScale";
        private readonly string sSSPower = "_SSSPower";
        private readonly string shadowStrength = "_ShadowStrength";
        private readonly string pointLightPunchthrough = "_PointLightPunchthrough";
        private readonly string subsurfaceDistortion = "_SubsurfaceDistortion";
        private readonly string matcap = "_Matcap";
        private readonly string matcapMask = "_MatcapMask";
        private readonly string specularMask = "_SpecularMask";
        private readonly string specularColor = "_SpecularColor";
        private readonly string specularPower = "_SpecularStep";
        private readonly string specularSmoothness = "_SpecularSmoothness";
        private readonly string metallic = "_Metallic";
        private readonly string smoothness = "_Smoothness";
        private readonly string emmissiveMask = "_EmmissiveMask";
        private readonly string emmisiveColor = "_EmmisiveColor";
        private readonly string unlitIntensity = "_UnlitIntensity";
        private readonly string maskClipValue = "_MaskClipValue";
        private readonly string outlineMask = "_OutlineMask";
        private readonly string outlineColor = "_OutlineColor";
        private readonly string outlineWidth1 = "_OutlineWidth";
        private readonly string baseColorToOutlineColor = "_BaseColorToOutlineColor";
        private readonly string reference = "_Reference";
        private readonly string readMask = "_ReadMask";
        private readonly string writeMask = "_WriteMask";
        private readonly string compFront = "_CompFront";
        private readonly string passFront = "_PassFront";
        private readonly string failFront = "_FailFront";
        private readonly string zFailFront = "_ZFailFront";
        private readonly string compBack = "_CompBack";
        private readonly string passBack = "_PassBack";
        private readonly string failBack = "_FailBack";
        private readonly string zFailBack = "_ZFailBack";
        private readonly string cullMode = "_CullMode";
        private bool transparentMaskFold = false;
        private bool mainTexureFold = false;
        private bool stShadeMapFold = false;
        private bool baseColorStepFold = false;
        private bool normalFold = false;
        private bool useRimFold = false;
        private bool rimColorFold = false;
        private bool useSubsurfaceFold = false;
        private bool matcapFold = false;
        private bool specularMaskFold = false;
        private bool metallicFold = false;
        private bool emmissiveMaskFold = false;
        private bool unlitIntensityFold = false;
        private bool outlineMaskFold = false;
        private bool referenceFold = false;
        private bool cullModeFold = false;
        private bool useRimToggle = true;
        private bool useSubsurfaceToggle = true;

        private bool renderingFold = false;
        private bool firstInspectedEditor = true;

        #endregion

        public IsuzuToonShaderInspector() { }

        ///<inheritdoc />
        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {
            Undo.undoRedoPerformed += () => { materialEditor.Repaint(); };

            var material = materialEditor.target as Material;

            if (material == null) return;

            if (materialEditor.isVisible)
            {
                using (new GUILayout.HorizontalScope())
                {
                    if (GUILayout.Button("Copy Values"))
                    {
                        SaveMaterialProperties(material);
                    }

                    if (GUILayout.Button("Past Values"))
                    {
                        LoadMaterialProperties(material);
                        materialEditor.PropertiesChanged();
                    }
                }

                using (new GUILayout.HorizontalScope())
                {
                    if (GUILayout.Button("Export Template"))
                    {
                        SaveTemplateData(material);
                    }

                    if (GUILayout.Button("Import Template"))
                    {
                        LoadTemplateData(material);
                        materialEditor.PropertiesChanged();
                    }
                }

                GUILayout.Space(5);
            }

            var transparentMaskProp = FindProperty(this.transparentMask, properties, false);
            var transparencyProp = FindProperty(this.transparency, properties, false);
            var transparentisBaseTextureProp = FindProperty(this.transparentisBaseTexture, properties, false);
            var mainTexureProp = FindProperty(this.mainTexure, properties, false);
            var baseColorProp = FindProperty(this.baseColor, properties, false);
            var stShadeMapProp = FindProperty(this.stShadeMap, properties, false);
            var stShadeColorProp = FindProperty(this.stShadeColor, properties, false);
            var ndShadeMapProp = FindProperty(this.ndShadeMap, properties, false);
            var ndShadeColorProp = FindProperty(this.ndShadeColor, properties, false);
            var baseColorStepProp = FindProperty(this.baseColorStep, properties, false);
            var baseShadeSoftnessProp = FindProperty(this.baseShadeSoftness, properties, false);
            var shadeColorStepProp = FindProperty(this.shadeColorStep, properties, false);
            var st2ndShadeSoftnessProp = FindProperty(this.st2ndShadeSoftness, properties, false);
            var normalProp = FindProperty(this.normal, properties, false);
            var normalScaleProp = FindProperty(this.normalScale, properties, false);
            var useRimProp = FindProperty(this.useRim, properties, false);
            var rimColorProp = FindProperty(this.rimColor, properties, false);
            var rimLightMaskProp = FindProperty(this.rimLightMask, properties, false);
            var rimPowerProp = FindProperty(this.rimPower, properties, false);
            var rimOffsetProp = FindProperty(this.rimOffset, properties, false);
            var rimBiasProp = FindProperty(this.rimBias, properties, false);
            var useSubsurfaceProp = FindProperty(this.useSubsurface, properties, false);
            var sSSMapProp = FindProperty(this.sSSMap, properties, false);
            var sSSMultiplierProp = FindProperty(this.sSSMultiplier, properties, false);
            var sSSColorProp = FindProperty(this.sSSColor, properties, false);
            var sSSColorPowerProp = FindProperty(this.sSSColorPower, properties, false);
            var sSSScaleProp = FindProperty(this.sSSScale, properties, false);
            var sSSPowerProp = FindProperty(this.sSSPower, properties, false);
            var shadowStrengthProp = FindProperty(this.shadowStrength, properties, false);
            var pointLightPunchthroughProp = FindProperty(this.pointLightPunchthrough, properties, false);
            var subsurfaceDistortionProp = FindProperty(this.subsurfaceDistortion, properties, false);
            var matcapProp = FindProperty(this.matcap, properties, false);
            var matcapMaskProp = FindProperty(this.matcapMask, properties, false);
            var specularMaskProp = FindProperty(this.specularMask, properties, false);
            var specularColorProp = FindProperty(this.specularColor, properties, false);
            var specularPowerProp = FindProperty(this.specularPower, properties, false);
            var specularSmoothnessProp = FindProperty(this.specularSmoothness, properties, false);
            var metallicProp = FindProperty(this.metallic, properties, false);
            var smoothnessProp = FindProperty(this.smoothness, properties, false);
            var emmissiveMaskProp = FindProperty(this.emmissiveMask, properties, false);
            var emmisiveColorProp = FindProperty(this.emmisiveColor, properties, false);
            var unlitIntensityProp = FindProperty(this.unlitIntensity, properties, false);
            var maskClipValueProp = FindProperty(this.maskClipValue, properties, false);
            var outlineMaskProp = FindProperty(this.outlineMask, properties, false);
            var outlineColorProp = FindProperty(this.outlineColor, properties, false);
            var outlineWidth1Prop = FindProperty(this.outlineWidth1, properties, false);
            var baseColorToOutlineColorProp = FindProperty(this.baseColorToOutlineColor, properties, false);
            var referenceProp = FindProperty(this.reference, properties, false);
            var readMaskProp = FindProperty(this.readMask, properties, false);
            var writeMaskProp = FindProperty(this.writeMask, properties, false);
            var compFrontProp = FindProperty(this.compFront, properties, false);
            var passFrontProp = FindProperty(this.passFront, properties, false);
            var failFrontProp = FindProperty(this.failFront, properties, false);
            var zFailFrontProp = FindProperty(this.zFailFront, properties, false);
            var compBackProp = FindProperty(this.compBack, properties, false);
            var passBackProp = FindProperty(this.passBack, properties, false);
            var failBackProp = FindProperty(this.failBack, properties, false);
            var zFailBackProp = FindProperty(this.zFailBack, properties, false);
            var cullModeProp = FindProperty(this.cullMode, properties, false);

            using (var scope = new EditorGUI.ChangeCheckScope())
            {
                if (this.firstInspectedEditor)
                {
                    this.useRimToggle = useRimProp.floatValue > 0;
                    this.useSubsurfaceToggle = useSubsurfaceProp.floatValue > 0;
                    this.firstInspectedEditor = false;
                }

                CustomInspectorUIUtility.SetKeyword(useRimProp, this.useRimToggle);
                CustomInspectorUIUtility.SetKeyword(useSubsurfaceProp, this.useSubsurfaceToggle);

                materialEditor.SetDefaultGUIWidths();

                CustomInspectorUIUtility.PropertyFoldGroup("Rendering", ref this.cullModeFold,
                    () => { materialEditor.ShaderProperty(cullModeProp, "Cull Mode"); });

                if (transparentMaskProp != null)
                    CustomInspectorUIUtility.PropertyFoldGroup("Transparency Settings", ref this.transparentMaskFold, () =>
                    {
                        materialEditor.TexturePropertySingleLine(new GUIContent("Transparent Mask"),
                            transparentMaskProp);
                        materialEditor.ShaderProperty(transparencyProp, "Transparency");
                        materialEditor.ShaderProperty(maskClipValueProp, "Mask Clip Value");
                        materialEditor.ShaderProperty(transparentisBaseTextureProp, "Transparent is Base Texture");
                    });

                CustomInspectorUIUtility.PropertyFoldGroup("Base Map", ref this.mainTexureFold, () =>
                {
                    materialEditor.TexturePropertySingleLine(new GUIContent("Main Texure"), mainTexureProp);
                    materialEditor.ShaderProperty(baseColorProp, "Base Color");
                });

                CustomInspectorUIUtility.PropertyFoldGroup("Shadow Settings", ref this.stShadeMapFold, () =>
                {
                    materialEditor.TexturePropertySingleLine(new GUIContent("1st Shade Map"), stShadeMapProp);
                    materialEditor.ShaderProperty(stShadeColorProp, "1st Shade Color");
                    materialEditor.TexturePropertySingleLine(new GUIContent("2nd Shade Map"), ndShadeMapProp);
                    materialEditor.ShaderProperty(ndShadeColorProp, "2nd Shade Color");
                });

                CustomInspectorUIUtility.PropertyFoldGroup("Toon Shade Settings", ref this.baseColorStepFold, () =>
                {
                    materialEditor.ShaderProperty(baseColorStepProp, "Base Color Step");
                    materialEditor.ShaderProperty(baseShadeSoftnessProp, "Base Shade Softness");
                    materialEditor.ShaderProperty(shadeColorStepProp, "Shade Color Step");
                    materialEditor.ShaderProperty(st2ndShadeSoftnessProp, "1st2nd Shade Softness");
                });

                CustomInspectorUIUtility.PropertyFoldGroup("Normal Settings", ref this.normalFold, () =>
                {
                    materialEditor.ShaderProperty(normalProp, "Normal");
                    materialEditor.ShaderProperty(normalScaleProp, "Normal Scale");
                });

                CustomInspectorUIUtility.PropertyToggleFoldGroup("Rim Settings", ref this.rimColorFold, ref this.useRimToggle, () =>
                {
                    materialEditor.ShaderProperty(rimLightMaskProp, "RimLight Mask");
                    materialEditor.ShaderProperty(rimColorProp, "Rim Color");
                    materialEditor.ShaderProperty(rimPowerProp, "Rim Power");
                    materialEditor.ShaderProperty(rimOffsetProp, "Rim Offset");
                    materialEditor.ShaderProperty(rimBiasProp, "Rim Bias");
                });

                CustomInspectorUIUtility.PropertyToggleFoldGroup("Subsurface Settings", ref this.useSubsurfaceFold,
                    ref this.useSubsurfaceToggle, () =>
                    {
                        materialEditor.ShaderProperty(sSSMapProp, "SSS Map");
                        materialEditor.ShaderProperty(sSSMultiplierProp, "SSS Multiplier");
                        materialEditor.ShaderProperty(sSSColorProp, "SSS Color");
                        materialEditor.ShaderProperty(sSSColorPowerProp, "SSS Color Power");
                        materialEditor.ShaderProperty(sSSScaleProp, "SSS Scale");
                        materialEditor.ShaderProperty(sSSPowerProp, "SSS Power");
                        materialEditor.ShaderProperty(shadowStrengthProp, "Shadow Strength");
                        materialEditor.ShaderProperty(pointLightPunchthroughProp, "Point Light Punchthrough");
                        materialEditor.ShaderProperty(subsurfaceDistortionProp, "Subsurface Distortion");
                    });

                CustomInspectorUIUtility.PropertyFoldGroup("Matcap Settings", ref this.matcapFold, () =>
                {
                    materialEditor.TexturePropertySingleLine(new GUIContent("Matcap"), matcapProp);
                    materialEditor.TexturePropertySingleLine(new GUIContent("Matcap Mask"), matcapMaskProp);
                });

                CustomInspectorUIUtility.PropertyFoldGroup("Metallic Settings", ref this.metallicFold, () =>
                {
                    materialEditor.ShaderProperty(metallicProp, "Metallic");
                    materialEditor.ShaderProperty(smoothnessProp, "Smoothness");
                });

                CustomInspectorUIUtility.PropertyFoldGroup("Specular Settings", ref this.specularMaskFold, () =>
                {
                    materialEditor.TexturePropertySingleLine(new GUIContent("Specular Mask"), specularMaskProp);
                    materialEditor.ShaderProperty(specularColorProp, "Specular Color");
                    materialEditor.ShaderProperty(specularPowerProp, "Specular Step");
                    materialEditor.ShaderProperty(specularSmoothnessProp, "Specular Softness");
                });

                CustomInspectorUIUtility.PropertyFoldGroup("Emmisive Settings", ref this.emmissiveMaskFold, () =>
                {
                    materialEditor.TexturePropertySingleLine(new GUIContent("Emmissive Mask"), emmissiveMaskProp);
                    materialEditor.ShaderProperty(emmisiveColorProp, "Emmisive Color");
                });

                CustomInspectorUIUtility.PropertyFoldGroup("Light Settings", ref this.unlitIntensityFold,
                    () => { materialEditor.ShaderProperty(unlitIntensityProp, "Unlit Intensity"); });

                if(outlineMaskProp != null)
                CustomInspectorUIUtility.PropertyFoldGroup("Outline Settings", ref this.outlineMaskFold, () =>
                {
                    materialEditor.TexturePropertySingleLine(new GUIContent("Outline Mask"), outlineMaskProp);
                    materialEditor.ShaderProperty(outlineColorProp, "Outline Color");
                    materialEditor.ShaderProperty(outlineWidth1Prop, "Outline Width");
                });

                CustomInspectorUIUtility.PropertyFoldGroup("Stencil Buffer", ref this.referenceFold, () =>
                {
                    materialEditor.ShaderProperty(referenceProp, "Reference");
                    materialEditor.ShaderProperty(readMaskProp, "Read Mask");
                    materialEditor.ShaderProperty(writeMaskProp, "Write Mask");
                    materialEditor.ShaderProperty(compFrontProp, "Comp. Front");
                    materialEditor.ShaderProperty(passFrontProp, "Pass Front");
                    materialEditor.ShaderProperty(failFrontProp, "Fail Front");
                    materialEditor.ShaderProperty(zFailFrontProp, "ZFail Front");
                    materialEditor.ShaderProperty(compBackProp, "Comp. Back");
                    materialEditor.ShaderProperty(passBackProp, "Pass Back");
                    materialEditor.ShaderProperty(failBackProp, "Fail Back");
                    materialEditor.ShaderProperty(zFailBackProp, "ZFail Back");
                });

                CustomInspectorUIUtility.PropertyFoldGroup("Other", ref this.renderingFold, () =>
                {
                    materialEditor.RenderQueueField();
#if UNITY_5_6_OR_NEWER
                    materialEditor.EnableInstancingField();
#endif
#if UNITY_5_6_2 || UNITY_5_6_3 || UNITY_5_6_4 || UNITY_2017_1_OR_NEWER
                    materialEditor.DoubleSidedGIField();
#endif
                    materialEditor.LightmapEmissionProperty();
                });
            }
        }

        private static void LoadMaterialProperties(Material material)
        {
            Thread.CurrentThread.CurrentCulture = CultureInfo.InvariantCulture;
            var data = EditorPrefs.GetString("e09b10ae611307c478957a841f00a53d", string.Empty);
            if (string.IsNullOrEmpty(data)) return;

            var properties = data.Split(';');

            try
            {
                for (var i = 0; i < properties.Length; i++)
                {
                    var values = properties[i].Split(':');
                    if (values.Length != 3) return;
                    if (!material.HasProperty(values[0])) return;

                    var type = (ShaderUtil.ShaderPropertyType) Enum.Parse(typeof(ShaderUtil.ShaderPropertyType),
                        values[1]);

                    switch (type)
                    {
                        case ShaderUtil.ShaderPropertyType.Color:
                            var colors = values[2].Split(',');
                            if (colors.Length != 4) break;
                            material.SetColor(values[0], new Color
                            (
                                Convert.ToSingle(colors[0]),
                                Convert.ToSingle(colors[1]),
                                Convert.ToSingle(colors[2]),
                                Convert.ToSingle(colors[3])
                            ));
                            break;
                        case ShaderUtil.ShaderPropertyType.Vector:
                            var vectors = values[2].Split(',');
                            if (vectors.Length != 4) break;
                            material.SetVector(values[0], new Color
                            (
                                Convert.ToSingle(vectors[0]),
                                Convert.ToSingle(vectors[1]),
                                Convert.ToSingle(vectors[2]),
                                Convert.ToSingle(vectors[3])
                            ));
                            break;
                        case ShaderUtil.ShaderPropertyType.Float:
                            material.SetFloat(values[0], Convert.ToSingle(values[2]));
                            break;
                        case ShaderUtil.ShaderPropertyType.Range:
                            material.SetFloat(values[0], Convert.ToSingle(values[2]));
                            break;
                        case ShaderUtil.ShaderPropertyType.TexEnv:
                            var testures = values[2].Split(',');
                            if (testures.Length != 5) break;
                            material.SetTexture(values[0], AssetDatabase.LoadAssetAtPath<Texture>(testures[0]));
                            material.SetTextureOffset(values[0], new Vector2
                            (
                                Convert.ToSingle(testures[1]),
                                Convert.ToSingle(testures[2])
                            ));
                            material.SetTextureScale(values[0], new Vector2
                            (
                                Convert.ToSingle(testures[3]),
                                Convert.ToSingle(testures[4])
                            ));
                            break;
                    }
                }
            }
            catch (Exception e)
            {
                Debug.LogException(e);
            }

            Thread.CurrentThread.CurrentCulture = CultureInfo.CurrentUICulture;
        }

        private static void SaveMaterialProperties(Material material)
        {
            Thread.CurrentThread.CurrentCulture = CultureInfo.InvariantCulture;
            var shader = material.shader;
            var propertyCount = ShaderUtil.GetPropertyCount(shader);
            var data = string.Empty;

            for (var i = 0; i < propertyCount; i++)
            {
                var type = ShaderUtil.GetPropertyType(shader, i);
                var name = ShaderUtil.GetPropertyName(shader, i);
                var value = string.Empty;
                switch (type)
                {
                    case ShaderUtil.ShaderPropertyType.Color:
                        var color = material.GetColor(name);
                        value = string.Format("{0},{1},{2},{3}", color.r, color.g, color.b, color.a);
                        break;
                    case ShaderUtil.ShaderPropertyType.Vector:
                        var vector = material.GetVector(name);
                        value = string.Format("{0},{1},{2},{3}", vector.x, vector.y, vector.z, vector.w);
                        break;
                    case ShaderUtil.ShaderPropertyType.Float:
                        value = material.GetFloat(name).ToString();
                        break;
                    case ShaderUtil.ShaderPropertyType.Range:
                        value = material.GetFloat(name).ToString();
                        break;
                    case ShaderUtil.ShaderPropertyType.TexEnv:
                        var texture = material.GetTexture(name);
                        value = AssetDatabase.GetAssetPath(texture);
                        var offset = material.GetTextureOffset(name);
                        var scale = material.GetTextureScale(name);
                        value += string.Format(",{0},{1},{2},{3}", offset.x, offset.y, scale.x, scale.y);
                        break;
                }

                data += string.Format("{0}:{1}:{2}", name, type, value);

                if (i < propertyCount - 1) data += ";";
            }

            EditorPrefs.SetString("e09b10ae611307c478957a841f00a53d", data);
            Thread.CurrentThread.CurrentCulture = Thread.CurrentThread.CurrentUICulture;
        }

        private static void SaveTemplateData(Material material)
        {
            Thread.CurrentThread.CurrentCulture = CultureInfo.InvariantCulture;
            var shader = material.shader;
            var propertyCount = ShaderUtil.GetPropertyCount(shader);
            var data = string.Empty;

            for (var i = 0; i < propertyCount; i++)
            {
                var type = ShaderUtil.GetPropertyType(shader, i);
                var name = ShaderUtil.GetPropertyName(shader, i);
                var value = string.Empty;
                switch (type)
                {
                    case ShaderUtil.ShaderPropertyType.Color:
                        var color = material.GetColor(name);
                        value = string.Format("{0},{1},{2},{3}", color.r, color.g, color.b, color.a);
                        break;
                    case ShaderUtil.ShaderPropertyType.Vector:
                        var vector = material.GetVector(name);
                        value = string.Format("{0},{1},{2},{3}", vector.x, vector.y, vector.z, vector.w);
                        break;
                    case ShaderUtil.ShaderPropertyType.Float:
                        value = material.GetFloat(name).ToString();
                        break;
                    case ShaderUtil.ShaderPropertyType.Range:
                        value = material.GetFloat(name).ToString();
                        break;
                    case ShaderUtil.ShaderPropertyType.TexEnv:
                        var texture = material.GetTexture(name);
                        value = AssetDatabase.GetAssetPath(texture);
                        var offset = material.GetTextureOffset(name);
                        var scale = material.GetTextureScale(name);
                        value += string.Format(",{0},{1},{2},{3}", offset.x, offset.y, scale.x, scale.y);
                        break;
                }

                data += string.Format("{0}:{1}:{2}", name, type, value);


                if (i < propertyCount - 1) data += ";";
            }

            EditorPrefs.SetString("e09b10ae611307c478957a841f00a53d", data);

            var filePath = EditorUtility.SaveFilePanel("Create New Isuzu Shader Template", Application.dataPath,
                "New IsuzuShaderTemplate", "shadertemp");

            if (string.IsNullOrEmpty(filePath)) return;

            using (var writer = new StreamWriter(filePath, false))
            {
                writer.Write(data);
                writer.Flush();
                writer.Close();
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            Thread.CurrentThread.CurrentCulture = Thread.CurrentThread.CurrentUICulture;
        }

        private static void LoadTemplateData(Material material)
        {
            Thread.CurrentThread.CurrentCulture = CultureInfo.InvariantCulture;

            var filePath =
                EditorUtility.OpenFilePanel("Select Isuzu Shader Template", Application.dataPath, "shadertemp");
            if (string.IsNullOrEmpty(filePath)) return;

            var data = string.Empty;
            using (var sr = new StreamReader(filePath))
            {
                data = sr.ReadToEnd();
                sr.Close();
            }

            if (string.IsNullOrEmpty(data)) return;

            var properties = data.Split(';');

            try
            {
                for (var i = 0; i < properties.Length; i++)
                {
                    var values = properties[i].Split(':');
                    if (values.Length != 3) return;
                    if (!material.HasProperty(values[0])) return;

                    var type = (ShaderUtil.ShaderPropertyType) Enum.Parse(typeof(ShaderUtil.ShaderPropertyType),
                        values[1]);

                    switch (type)
                    {
                        case ShaderUtil.ShaderPropertyType.Color:
                            var colors = values[2].Split(',');
                            if (colors.Length != 4) break;
                            material.SetColor(values[0], new Color
                            (
                                Convert.ToSingle(colors[0]),
                                Convert.ToSingle(colors[1]),
                                Convert.ToSingle(colors[2]),
                                Convert.ToSingle(colors[3])
                            ));
                            break;
                        case ShaderUtil.ShaderPropertyType.Vector:
                            var vectors = values[2].Split(',');
                            if (vectors.Length != 4) break;
                            material.SetVector(values[0], new Color
                            (
                                Convert.ToSingle(vectors[0]),
                                Convert.ToSingle(vectors[1]),
                                Convert.ToSingle(vectors[2]),
                                Convert.ToSingle(vectors[3])
                            ));
                            break;
                        case ShaderUtil.ShaderPropertyType.Float:
                            material.SetFloat(values[0], Convert.ToSingle(values[2]));
                            break;
                        case ShaderUtil.ShaderPropertyType.Range:
                            material.SetFloat(values[0], Convert.ToSingle(values[2]));
                            break;
                        case ShaderUtil.ShaderPropertyType.TexEnv:
                            var testures = values[2].Split(',');
                            if (testures.Length != 5) break;
                            material.SetTexture(values[0], AssetDatabase.LoadAssetAtPath<Texture>(testures[0]));
                            material.SetTextureOffset(values[0], new Vector2
                            (
                                Convert.ToSingle(testures[1]),
                                Convert.ToSingle(testures[2])
                            ));
                            material.SetTextureScale(values[0], new Vector2
                            (
                                Convert.ToSingle(testures[3]),
                                Convert.ToSingle(testures[4])
                            ));
                            break;
                    }
                }
            }
            catch (Exception e)
            {
                Debug.LogException(e);
            }

            Thread.CurrentThread.CurrentCulture = CultureInfo.CurrentUICulture;
        }
    }
}

