run("Set Scale...", "distance=256 known=1 unit=inch global");
setAutoThreshold("Li dark");
setOption("BlackBackground", true);
run("Convert to Mask");

roiManager("reset");
run("Clear Results");

run("Options...", "iterations=1 count=1 black");
run("Dilate");
run("Outline");

run("Shape Filter", "area=0.02-Infinity area_convex_hull=0-Infinity perimeter=0-Infinity perimeter_convex_hull=0-Infinity feret_diameter=0-Infinity min._feret_diameter=0-Infinity max._inscr._circle_diameter=0-Infinity area_eq._circle_diameter=0-Infinity long_side_min._bounding_rect.=0-Infinity short_side_min._bounding_rect.=0-Infinity aspect_ratio=1-Infinity area_to_perimeter_ratio=0-Infinity circularity=0-Infinity elongation=0-1 convexity=0-1 solidity=0-1 num._of_holes=0-Infinity thinnes_ratio=0-1 contour_temperatur=0-1 orientation=0-180 fractal_box_dimension=0-2 option->box-sizes=2,3,4,6,8,12,16,32,64 add_to_manager draw_holes fill_results_table exclude_on_edges");

roiManager("Show All");
roiManager("UseNames", "true");

nb_Obj = roiManager("count");

for (i = 0 ; i < nb_Obj ; i++) {

	roiManager("select", i) ;
	circ = getResult("Circ.", i) ;
	peri = getResult("Peri.", i) ;
	trou = getResult("Num. of Holes", i) ;
	area = getResult("Area", i) ;
 	max_diam_circl = getResult("Maximum inscriped circle diameter", i) ;
	
	// Arbre de décision
	
	if( circ > 50 && circ < 103 && peri > 2 && peri < 4 && max_diam_circl > 0.086 && max_diam_circl < 0.37) {
		setResult("Label", i, "Clef") ;
		roiManager("Rename", "Clef") ;

	} else {

		if(peri < 0.7 && peri > 0.5 && circ < 14 && circ > 12.9 && trou >= 1 && trou <= 6 && area > 0.022 && area < 0.028) {
			setResult("Label", i, "Dé " + trou) ;
			roiManager("Rename", "Dé " + trou) ;

		} else {

 			if(area > 0.020 && area < 0.05 && peri < 0.8 && peri > 0.6 && trou == 1) {
 				setResult("Label", i, "Rondelle") ;
				roiManager("Rename", "Rondelle") ;

			} else {
				if(circ < 13 && circ > 11 && peri < 2 && peri > 0.5 && trou == 0 && area < 0.12 && area > 0.029){
					setResult("Label", i, "Pièce") ;
					roiManager("Rename", "Pièce") ;

				} else {
					setResult("Label", i, "Rejet") ;
					roiManager("Rename", "Rejet") ;
				}
			}
		}
	}
}

// Pour remplacer les noms du roiManager par les labels sur l'image
roiManager("Show All with labels") ;
