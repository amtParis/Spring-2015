// Fragment shader to perform Analyphic 3D conversion of two textures from the left and right eyes
// by r3dux
// source: http://r3dux.org/2011/05/anaglyphic-3d-in-glsl/

// Adapted for Processing by Raphaël de Courville 
// Twitter: @sableRaph

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

//uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform sampler2D Left;
uniform sampler2D Right;
uniform int colorOrder;

// colorOrder:
// 0 = red-cyan
// 1 = cyan-red

//uniform float time;
//uniform vec2 resolution;
//uniform vec2 mouse;
 
vec4 leftFrag;
vec4 rightFrag;


void main(void)
{
	leftFrag = texture2D(Left, vertTexCoord.st);
    rightFrag = texture2D(Right, vertTexCoord.st);
    
    if(colorOrder == 0){
        // left red, right cyan
        leftFrag  = vec4(1.0, leftFrag.g, leftFrag.b, 1.0); // full red
        rightFrag = vec4(rightFrag.r, 1.0, 1.0, 1.0); // full cyan
    }else {
        // left cyan, right red
        leftFrag = vec4(leftFrag.r, 1.0, 1.0, 1.0); // full cyan
        rightFrag  = vec4(1.0, rightFrag.g, rightFrag.b, 1.0); // full red
    }
    
	// Multiply left and right components for final output colour
	gl_FragColor = vec4(leftFrag.rgb * rightFrag.rgb, 1.0);

	// Test
  	//gl_FragColor = texture2D(texture, vertTexCoord.st) * vertColor;
}