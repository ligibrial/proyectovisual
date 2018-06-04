#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform int size;
uniform vec2 texOffset;
uniform float width = 1600;
uniform float height = 900;
uniform float[1] effect1;
uniform float[9] effect3;
uniform float[25] effect5;

varying vec4 vertColor;
varying vec4 vertTexCoord;

const float step_w = 1.0/width;
const float step_h = 1.0/height;

const vec2 texOffset1[1] = {vec2(0.0, 0.0)};
const vec2 texOffset3[9] = {vec2(-step_w, -step_h), vec2(0.0, -step_h), vec2(step_w, -step_h), 
							vec2(-step_w, 0.0),		vec2(0.0, 0.0), 	vec2(step_w, 0.0), 
							vec2(-step_w, step_h),  vec2(0.0, step_h),  vec2(step_w, step_h) };
const vec2 texOffset5[25] = {vec2(-step_w*2.0, -step_h*2.0), vec2(-step_w, -step_h*2.0), vec2(0.0, -step_h*2.0), vec2(step_w, -step_h*2.0), vec2(step_w*2, -step_h*2.0), 
							 vec2(-step_w*2.0, -step_h), 	 vec2(-step_w, -step_h), 	 vec2(0.0, -step_h), 	 vec2(step_w, -step_h),	    vec2(step_w*2, -step_h), 
							 vec2(-step_w*2.0, 0.0), 		 vec2(-step_w, 0.0), 	     vec2(0.0, 0.0), 		 vec2(step_w, 0.0), 		vec2(step_w*2, 0.0), 
							 vec2(-step_w*2.0, step_h), 	 vec2(-step_w, step_h), 	 vec2(0.0, step_h), 	 vec2(step_w, step_h), 	    vec2(step_w*2, step_h), 
							 vec2(-step_w*2.0, step_h*2.0),  vec2(-step_w, step_h*2.0),  vec2(0.0, step_h*2.0),  vec2(step_w, step_h*2.0),  vec2(step_w*2, step_h*2.0)};

void main() {
	vec4 sum = vec4(0.0);
	int total = size*size;
	
	switch(size){
		case 1:
			for(int i=0; i < total; i++){
				sum += effect1[i] * texture2D(texture, vertTexCoord.st + texOffset1[i]);
			}
			break;
		case 3:
			for(int i=0; i < total; i++){
				sum += (effect3[i] * texture2D(texture, vertTexCoord.st + texOffset3[i]));
			}
			break;
		case 5:
			for(int i=0; i < total; i++){
				sum += (effect5[i] * texture2D(texture, vertTexCoord.st + texOffset5[i]));
			}
			break;
	}
	
	gl_FragColor = vec4(sum.rgb, 1) * vertColor;
}