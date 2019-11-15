using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class Mapping
{
    static float d = 1f;
    static float a = 0.5f;
    static int n = 5;
    static float g = n * Mathf.PI * 2;
    static float b = 1f;
    static float c = 0f;

    public static Vector2 s(Vector2 v, float t)
    {
        float s = d * v.x + (a / g) * (Mathf.Cos(t * b + c) - Mathf.Cos(t * b + c + g * v.x));
        return new Vector2(s, v.y);
    }
}
