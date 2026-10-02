import pandas as pd
import numpy as np

import nd2 
import tifffile
from tifffile import imwrite
import xarray
from pathlib import Path

    
print("file start")

def nd2stack_to_MIP(input_folder, output_folder, overwrite= False):  # defines a function where I can specifiy a folder of nd2 files and it will turn them into single channel MIP TIFs

    input_folder = Path(input_folder) # define what folder of nd2 files to read in
    output_folder = Path(output_folder)

 # create two folders using the output folder specified. 

    parent= output_folder.parent # I want to create two output folders, so this is specifying the parent, in order to define the subfolders
    base = output_folder.name # defining the base name as whatever I put into the function

 #   omero_dir = parent / f"{base}_MIPs_forOMERO" # create first subfolder. 
 #   omero_dir.mkdir(parents=True, exist_ok=True) # if folder doesn't exist, create it. If it does, this code prevents script from breaking
    single_dir = parent / f"{base}_singlechannelTIF" # same as above, but single channels for vjunctr
    single_dir.mkdir(parents=True, exist_ok=True)

 
    for nd2_file in input_folder.glob("*.nd2"):  # for every ND2 file in the input folder, do the following
        print(f"Processing {nd2_file.name}")    #progress message

        with nd2.ND2File(nd2_file) as f:         # make the file an object called f
            x=f.to_xarray()                     # turn into an array
   #Make everything into MIPS
            if 'Z' in x.dims:
                mip = x.max(dim='Z')            # if stacks, make MIP
            else:
                raise ValueError(f"{nd2_file.name} has no Z axis — cannot compute MIP.") #otherwise print error msg
    
            # Write one MIP TIFF per channel.
            if "C" in mip.dims:
                for c in range(mip.sizes["C"]):
                    img = np.asarray(mip.isel(C=c))
                    out_path = single_dir / f"{nd2_file.stem}_ch{c}.tif"
                    if overwrite or not out_path.exists():
                        imwrite(out_path, img)
            else:
                img = np.asarray(mip)
                out_path = single_dir / f"{nd2_file.stem}.tif"
                if overwrite or not out_path.exists():
                    imwrite(out_path, img)
        print(f"Finished {nd2_file.name}\n")

#done
#nd2stack_to_MIP(input_folder= "Y:/Cynthia/Drugscreen paper/redo2drugscreen1T4cocktailA_260523",output_folder="C:/Git folder/Proper drugscreenpaper/drugscreenT4cocktailAvjunctr",overwrite=True)
nd2stack_to_MIP(input_folder= "Y:/Cynthia/Drugscreen paper/drugscreen1T24cocktailA_260525",output_folder="C:/Git folder/Proper drugscreenpaper/drugscreenT24cocktailAvjunctr",overwrite=True)

nd2stack_to_MIP(input_folder= "Y:/Cynthia/Drugscreen paper/drugscreen1T12cocktailB_260528",output_folder="C:/Git folder/Proper drugscreenpaper/drugscreenT24cocktailBjunctr",overwrite=True)
nd2stack_to_MIP(input_folder= "Y:/Cynthia/Drugscreen paper/newdrugscreen1T4cocktailB_260527",output_folder="C:/Git folder/Proper drugscreenpaper/drugscreenT4cocktailBjunctr",overwrite=True)

print("end of file")
# to run, PS C:\Users\cgao801\AppData\Local\Programs\Microsoft VS Code> python "c:\Git folder\Proper drugscreenpaper\nd2stacktoMIPs.py"