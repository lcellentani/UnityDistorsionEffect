Shader "Distorsion Effect (using Particles)"
{
	Properties
	{
		_MainTex("Texture (R,G=X,Y Distortion; B=Mask; A=Unused)", 2D) = "white" {}
		_IntensityAndScrolling("Intensity (XY); Scrolling (ZW)", Vector) = (0.1, 0.1, 1, 1)
		_DistanceFade("Distance Fade (X=Near, Y=Far, ZW=Unused)", Float) = (20, 50, 0, 0)
		[Toggle(USE_MASK)] _USE_MASK("Texture Blue channel is Mask", Float) = 0
		[Toggle(MIRROR_EDGE)] _MIRROR_EDGE("Mirror screen borders", Float) = 0

		[Toggle(DEBUGUV)] _DEBUGUV("Debug Texture Coordinates", Float) = 0
		[Toggle(DEBUGDISTANCEFADE)] _DEBUGDISTANCEFADE("Debug Distance Fade", Float) = 0
	}
		
	SubShader
	{
		Tags{ "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
		Blend One Zero
		Cull Off
		Lighting Off
		ZWrite Off
		Fog{ Mode Off }
		AlphaTest Greater 0.001
		LOD 200

		// See http://docs.unity3d.com/Manual/SL-GrabPass.html
		// Will grab screen contents into a texture, but will only do that once per frame for
		// the first object that uses the given texture name. 
		GrabPass{ "_GrabTexture" }

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma shader_feature USE_MASK
			#pragma shader_feature MIRROR_EDGE
			#pragma shader_feature DEBUGUV
			#pragma shader_feature DEBUGDISTANCEFADE

			#define ENABLE_CLIP 1

			#include "DistorsionEffect.cginc"
			ENDCG
		}
	}
}
