# Presley_Final_Project
Final Project for Bio539

This README Corresponds to 'Final_Project_Script.R' found in 'Bio539_Final_Project'/'Bio539_R_Scripts' at 
https://github.com/A-Presley/Presley_Final_Project.git 

Example data referenced can be found in 'Bio539_Final_Project'/'Bio_539_Data'at the github link above
Example results can be found in 'Bio539_Final_Project'/'Final_Results' 

Final_Project_Script.R acts as a versitile calculator for generating Stacked Bar Plots summarizing relative abundance after 
resolving exisiting data to a higher resolution (species/OTU level from genus/class level)

At the begining of the script the User will be presented with 4 varriable inputs: 
  - Var.1 <- is assigned to the master relative abundance csv, this script should be formated as follows: 
          Columns: 
    
                Column 1 "Sample ID", these should be unique identifiying values for each sample run  
     
                Column 2 "Treatment" (incubation conditions, etc)
    
                Columns 3-(n+1) Genus or Class taxonomy names for 1-'n' with 'n' being the number of assigned taxonomies
    
                For direct reference, see 'diatom_relabund_osp.csv' used as the model in this script
 
 - Var.2 <- Is assigned to the raw counts of ASVs/OTUs, formated as follows: 
          Columns: 
      
            Column 1 called "Sample ID", Sample IDs should be identical to those in the file used for var.1, as these are        
            used for alligning the files. 
      
            Column 2 "Treatment" this column should contain details on treatment similar to Var.1 dataset "Treatment" column
      
            Columns 3-(n+1) called "ASV1" - "ASVn" with 'n' being the total number of ASVs 
      
            Final Column called "Totals" containing total counts for each sample ID, values in each row should add up to the       
            value shown in that row's "Totals" cell 
      
            For direct reference see 'pn_asv_relabund_osp.csv' 
   
  - Var.3 <- This varriable is assinged the exact number of ASVs that you will be inputing in the Var.2 csv 
              (for this example Var.3 = 10 since we are breaking out the genus into 10 ASVs) 
              
  - Var.4 <- This varriable is assigned the name of the Genus or Class in the Var.1 csv that you want to break out into ASVs
             (This must EXATLY match the name of the column in the Var.1 csv, or there will be resulting errors) 
  - Var.5 <- This varriable is assigned the number of columns in the .csv input for Var.1 minus 2 as it should not count 
             treatment or Sample ID columns, only the taxonomical assignments that will be used in the final plot.  
After inputing all variables, run the R script one section at a time until you reach the optional renaming section, *if you do 
not input your own names as detailed below, skip this line*. 

        Assigning Taxonomy to your ASVs (Optional): 
        This is a manual process; as long as your ASVs followed the proper format for var.2, the only thing that should need 
        to be changed is the new names of the ASVs (these must be in double quotes ("new_name" = "ASVn_Ratio_RelAbun" with n    
        being the number ASV you want to reassign) these can be removed or added in accordance with the ammount of ASVs that    
        you want to assign new names. 

An optional step exists on line 40 to create a .RData of the calculated relative abundances for export to another existing 
script for graphing or data analysis 

To generate a plot using ggplot2, data must be in long format, the R script does this automatically using var.5 and var.3 
varriables on line 42 of the script, if errors are occuring or data in the long format table has more than 3 columns, check 
that var.3 and var.5 are correct. 

After runing the final section a Relative Abundance Plot of the new ASVs alongside the previously identified genera/classes 
will be generated for use names "ASV_Relative_Abundance_Plot.png". 
