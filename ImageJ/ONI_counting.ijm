path= newArray(1);

path[0]="/Volumes/Candace A/Candace/20221115_CTA_SC_PSD95/NoBSA_PSD95/pos_1/"
path[1]="/Volumes/Candace A/Candace/20221115_CTA_SC_PSD95/NoBSA_PSD95/pos_2/"
path[2]="/Volumes/Candace A/Candace/20221115_CTA_SC_PSD95/NoBSA_PSD95/pos_3/"
path[3]="/Volumes/Candace A/Candace/20221115_CTA_SC_PSD95/NoBSA_PSD95/pos_4/"
path[4]="/Volumes/Candace A/Candace/20221115_CTA_SC_PSD95/NoBSA_PSD95/pos_5/"
path[5]="/Volumes/Candace A/Candace/20221115_CTA_SC_PSD95/NoBSA_PSD95/pos_6/"
path[6]="/Volumes/Candace A/Candace/20221115_CTA_SC_PSD95/NoBSA_PSD95/pos_7/"
path[7]="/Volumes/Candace A/Candace/20221115_CTA_SC_PSD95/NoBSA_PSD95/pos_8/"


dir2 = getDirectory("Experiment directory"); // File containing all raw data
output_dir2 = dir2 + File.separator + "CountData" + File.separator
File.makeDirectory(output_dir2) //Make file to save counts


k=10;
for (i=0; i<path.length; i++){

count = 0;	
n=0;
dir=path[i];
dname = substring(dir, 49, 60); //name of data

processFiles(dir);
;

///////////// Allocate and process frames ///////////////

lhs_start=1;
lhs_end=200;

rhs_start=201;
rhs_end=400;

makeRectangle(1, 1, 428, 684); //  Create ROI for left channel

run("Duplicate...", "duplicate range="+lhs_start+"-"+lhs_end+"");
save(dir+"Left.tif");
run("Z Project...", "projection=[Max Intensity]");
save(dir+"Left_max.tif");
run("Find Maxima...", "prominence=80 output=Count");
close();
close();

makeRectangle(428, 1, 856, 684); // Create ROI for right channel

run("Duplicate...", "duplicate range="+rhs_start+"-"+rhs_end+"");
save(dir+"right.tif");
run("Z Project...", "projection=[Max Intensity]");
save(dir+"Right_max.tif");
run("Find Maxima...", "prominence=250 output=Count");
run("Close All");

}
selectWindow("Results");
saveAs("results", output_dir2 + dname + ".csv");
close("Results");


/////////// Function to process the files ///////////////

function processFiles(dir) 

	{

	list = getFileList(dir);

		for (i=0; i<list.length; i++)

		 {

		if (!startsWith(list[i],"Log"))

			{

			if (endsWith(list[i], "/"))

		              processFiles(""+dir+list[i]);

         			 else 

			{

		             showProgress(n++, count);

            			path = dir+list[i];

	            		processFile(path);

			}

			}

		}

	}

function processFile(path) 

	{
		       	if (endsWith(path, "posZ0.tif")) 
 
		{
			open(path);

			
	k++;
 			

		}
	}