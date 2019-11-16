Shader "Unlit/MapShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
			uniform float _TIME = 0.;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);

				float d = 1.;
				float a = 0.5;
				int n = 1;
				float g = n * 3.1415 * 2.;
				float b = 1.;
				float c = 0.;
				float x = i.uv[0];
				float t = _TIME;

				float e = a * sin(t * b + x * g + c) + d;
				float s = d * x + a / g * (cos(t * b + c) - cos(t * b + c + x * g));

				float s_ = s * n * 10;
				s_ -= floor(s_);
				//return fixed4(0., 0., s, 1.);
				//return fixed4(i.uv[0], i.uv[1], 0., 1.);
				if (s_ < 0.33){
					col = fixed4(1., 0., 0., 1.);
				} else if (s_ < 0.66){
					col = fixed4(0., 1., 0., 1.);
				} else{
					col = fixed4(0., 0., 1., 1.);
				}
				
                return col;
            }
            ENDCG
        }
    }
}
