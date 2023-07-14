
///////////////////// CREATE BACKGROUND IMAGE \\\\\\\\\\\\\\\\\\\\\\\\\\\\

bimg = getDirectory("Choose projected control images");

File.openSequence(bimg, "virtual start=2 step=2");
run("Z Project...", "projection=[Average Intensity]"); // get avg background image from control stack
run("Gaussian Blur...", "sigma=20"); // create new blurred background 
saveAs("Tiff", bimg + "Average BG");
run("Close All");

///////////////////////// SUBTRACT BG FROM IMAGES \\\\\\\\\\\\\\\\\\\\\\\\\\\

dir = getDirectory("Choose images to be processed ");
list1 = getFileList(dir);
output_dir = dir + "IP_Background_subtracted" + File.separator ;
File.makeDirectory(output_dir);
bg_image = File.openDialog("choose BG image");
open(bg_image);

setBatchMode(true);

for (i=0; i<list1.length; i++) {
	showProgress(i+1, list1.length);
	open(dir+list1[i]);
	imageCalculator("Subtract create", list1[i] , bg_image);
	saveAs("tif", output_dir +list1[i]);
	run("Close All");

	}
setBatchMode(false);
