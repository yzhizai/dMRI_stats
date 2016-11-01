function mixWatsonMainFunc_demo

filenames1 = cellstr(spm_select(Inf, 'image', 'choose dyads1 files'));
filenames2 = cellstr(spm_select(Inf, 'image', 'choose dyads2 files'));

[s1, s2, s] = mixWatsonMainFunc(filenames1, filenames2, n1, n2);

