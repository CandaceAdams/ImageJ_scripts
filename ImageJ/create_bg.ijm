bimg = getDirectory("Choose projected control images");


File.openSequence(bimg, "virtual start=2 step=2");
run("Z Project...", "projection=[Average Intensity]"); // get avg background image from control stack
run("Gaussian Blur...", "sigma=20"); // create new blurred background 
saveAs("Tiff", bimg + "Average BG");
run("Close All");
