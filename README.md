# dMRI_stats

## bedpostX
首先要在bedpostX中将所有的数据进行处理。后面主要使用的文件包括，dyads1.nii, dyads2.nii, mean_f1samples.nii和mean_f2samples.nii四个文件。之后利用Fdt生成FA图像，将FA图像配准到FMRIB58_FA_1mm这个标准空间的FA上，得到它的warp场。然后利用下面的命令，将上述的四个文件变换到标准空间：
```
applywarp --ref=${FSLDIR}/data/standard/FMRIB58_FA_1mm_brain --in=my_f<i> --warp=my_nonlinear_transf --out=my_warped_f<i>

vecreg -i dyads<i> -o my_warped_dyads<i> -r ${FSLDIR}/data/standard/FMRIB58_FA_1mm_brain -w my_nonlinear_transf
```

## pseudo-DT
### Tensor construction
要变换成张量数据进行分析，最主要的一点是利用上面的四幅图像构建一个可以用于分析的张量。整个构建过程是由`dataConvert.m`函数完成的。主要程序是：
```
vec1 = sign(vec1(3))*vec1; %modify the vector to align with the z-axis.
vec2 = sign(vec1'*vec2)*vec2; %promise the angle between two vector less than 90.

vec3 = cross(vec1, vec2);
vec3 = vec3/norm(vec3);

vec4 = cross(vec1, vec3);
vec4 = vec4/norm(vec4);

CosTheta = vec1'*vec2;

V = [vec1, vec3, vec4];
D = diag([f1, f2, CosTheta]);

siT = V*D/V;
```
构建完成之后，单个数据过于庞大（>700M），后面要进行数据分析同时导入多个被试的数据会非常消耗内存，所以分层进行数据分析。  
1. 首先利用`dataSlice.m`函数将数据分层；  
1. 然后利用`slice_folder.m`函数将不同被试的相同层放置到一个文件夹下；  
1. 最后利用`matT4D.m`函数将被试每一层叠加成一个4-D矩阵，第四维为被试；  
之后就可以使用`Hotelling_Stats.m`函数进行统计分析。  

## mixed-watson method
see the README.md in mixWatson folder
