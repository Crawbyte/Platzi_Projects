using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Mira : MonoBehaviour
{

    public float Sensitivity = 100f;

    public Transform Player1;

    float xRotation = 0f;

    // Start is called before the first frame update
    void Start()
    {
        //
        Cursor.lockState = CursorLockMode.Locked;//bloquea el cursor al centro de la ventana del juego 

    }

    // Update is called once per frame
    void Update()
    {
        float mouseX = Input.GetAxis("Mouse X") * Sensitivity * Time.deltaTime;//
        float mouseY = Input.GetAxis("Mouse Y") * Sensitivity * Time.deltaTime;

        xRotation -= mouseY;
        xRotation = Mathf.Clamp(xRotation, -90f, 75f);

        transform.localRotation = Quaternion.Euler(xRotation, 0f, 0f);//Quaternion se ocupa para almacenar rotaciones 
        Player1.Rotate(Vector3.up * mouseX);



    }
}