package com.services.wordcloudandmore

import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.widget.EditText
import android.widget.ImageButton
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import co.ceryle.radiorealbutton.RadioRealButton
import co.ceryle.radiorealbutton.RadioRealButtonGroup
import co.ceryle.radiorealbutton.RadioRealButtonGroup.OnLongClickedButtonListener


class MainActivity : AppCompatActivity() {

    private var editText:EditText?=null

    private var selection:Int=5;

    var radioGroup:RadioRealButtonGroup?=null

    var radioButton1:RadioRealButton?=null
    var radioButton2:RadioRealButton?=null

    var goButton:ImageButton?=null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        editText=findViewById(R.id.name_edit_text)

        goButton=findViewById(R.id.go_button)

        radioGroup=findViewById(R.id.radio_group)

        radioButton1=findViewById(R.id.rad_button1)
        radioButton2=findViewById(R.id.rad_button2)

        radioGroup!!.setOnClickedButtonListener { button, position ->
           selection=position
        }

// onPositionChanged listener detects if there is any change in position
        // onPositionChanged listener detects if there is any change in position
        radioGroup!!.setOnPositionChangedListener { button, currentPosition, lastPosition ->
            selection=currentPosition
        }




        goButton!!.setOnClickListener { v ->
            if(selection==1)
                startActivity(Intent(this@MainActivity,WordCloudDisplay::class.java))
            if(selection==0)
                editText!!.setText("")

        }



    }
}
