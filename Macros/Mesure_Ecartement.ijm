
run("Auto Threshold", "method=Otsu white");
run("Outline");
run("Auto Threshold", "method=Otsu white");

//setTool("line");
makeLine(240, 0, 240, 585);
profile=getProfile();
run("Plot Profile");

a = 0 ;
b = 0 ;
cpt = 0 ;
resolution = 1.956 ;

for (i=0; i < profile.length-1 ; i++){

    // Escalier pixel(i) pixel(i+1)
    if (profile[i] == 255) {
    	if (profile[i+1]==255){
    		cpt++ ; // ça revient à un + 2 si escalier
    	} 

	cpt++ ;

    }

    if (cpt == 1){
    	a = i ;
    }

    else if (cpt == 2){
    	b = i ;
    }


}

write("La largeur d'écartement est de " + (b-a)/resolution + "mm")
close() ;