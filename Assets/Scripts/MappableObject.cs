using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MappableObject : MonoBehaviour
{
    GameObject vis;

    void Start()
    {
        gameObject.GetComponent<MeshRenderer>().enabled = false;
        vis = GameObject.CreatePrimitive(PrimitiveType.Sphere);
        vis.transform.position = transform.position;
        vis.transform.localScale = transform.localScale;
    }

    // Update is called once per frame
    void Update()
    {
        float t = Time.time;
        var v = Mapping.s(new Vector2(transform.position.x, transform.position.y), t);
        vis.transform.position = new Vector3(v.x, v.y, vis.transform.position.z);
    }
}
