#BCB546X_Final_Project

Files are organized by what software was used for the analysis, each folder contains a README on how the analysis was done.
The original paper and data is saved in Raw_Data_and_Papers.
Figures_and_tables contains our recreations of the figures and tables in the paper.
Transformed_Data contains copies of the various transformations we had to make for the different software format requirements.

Lopez focused on Hp-RARE and DNASP
Paulsen focused on GenAlEx and R
Sisson focused on STRUCTURE and JMP
Zobrist focused on GenAlEx and Arlequin


##Figure 3

Figure 3 and the data in Table 4 could only be partially recreated as half of the data is unavailable to us. The figure and data was created using JMP10; however, JMP10 is no longer being distributed so I had to use the newest version, which is JMP14. 

Once we had the AR, PAR, Latitude, and DRM, we could easily plot the regressions between AR and Latitude/DRM and PAR and Latitude/DRM. All of the data was loaded into a single excel file and then imported into JMP14. The plots were generated by using the command "Fit Y by X" and having the AR or PAR serve as the Y variable and Latitude/DRM served as the X variable. Once the analysis was performed, a regression line was added by using a "Fit Line" command.


##Figure 4

The figure was generated using an open-source software called STRUCTURE. There have been many problems encountered with recreating this figure. 

###Problems:
- The software they used is not user friendly, especially compared to what we are used to today. Installing it was quite an adventure and took longer and more googling than I care to admit.
- A more up to date version of STRUCTURE was easier to download and install; however, this isn't the version they used in creating the figure, which could be a problem.
- However, the biggest problem I encountered: data format. The program is very rigid in the data format it requires to properly load and run. The authors don't designate what data manipulation they have performed on the raw data to prepare it for analysis in STRUCTURE. 
The STRUCTURE documentation is decent but lacks in some vital areas such as what should the data should look like to the program, not to us. However, the vast wealth of knowledge came from their google help page. This is where I stumbled onto a forum page that said one of the major issues they encounter is when data is created on a PC machine and an OSX or Linux user downloads it. The formatting becomes very messed up and the program can't read it. That sounds like what I encountered! I then tried to see if I could create one line of the data in a new document by typing it out, not by copying it. I found on one of the forum pages that there needs to be tabs within the rows and a return at the end of the row. I did this and the program was still reading the document as if there were way more rows and columns present. I was now back at square one with the same problem. 
- I also downloaded STRUCTURE 2.3.3 to see if a newer version would work. I could download and install the program, but everytime I launched the program, it gave me a fatal error saying the program was corrupted and I needed to uninstall.