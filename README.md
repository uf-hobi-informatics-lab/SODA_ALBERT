# Executing the SDoH extraction pipeline

## Running the pipeline from Docker:
### Required files:
- <b>Raw text directory</b>: location of the clinical notes from which you need to extract SDoH data
- <b>Output directory</b>: location where you wish to save the resulting file containing the extracted SDoH information

To run the pipeline, please execute the run.sh script included in this repository and make the following changes to the config.yml file:

>Set `root_dir` to your base directory where all files will be stored
>Set `raw_data_dir` to the directory housing the notes to be run under the pipeline (typically, this directory resides in your `root` directory)
>Set `pretrained_model` (line 28) and `new_model_dir` (line 85) to the location where you placed the NER and RE models, respectively.

Currently, the pipeline is configured to only store the resulting .csv output file to disk; to keep all intermediate files, add the `--debug` flag to the run.sh script.

 

# SDoH extraction NLP pipeline output format
The output file will be located under `{output_directory}/csv_output/`, and will contain 6 columns:
1.	Note ID as shown in the original input (note_id)
2.	Standardized category of SDoH predefined in SODA package, such as ‘Education’ or ‘Employment status’ (SDoH_standard_category)
3.	Extracted SDoH mentions in semi-structured SDoH sections, often followed by answers like ‘yes’ or ‘no’, such as ‘Physical abuse: yes’ or ’Tobacco use: no’ (SDoH_mention)
4.	Extracted raw SDoH status from notes, the answer part in the semi-structured SDoH sections, indicating the real status (SDoH_status_text)
5.	Normalized clinically meaningful groups of SDoH, such as ‘employed/unemployed’ (SDoH_normalized)
6.	Attributes extracted along with the SDoH, such as ‘Smoking years’ or ‘Smoking frequency’ (SDoH_attributes)

Currently, our rule-based normalization approach encompases the following categories categorizes the results into these possible values:
<table>
    <tr>
        <th>SDoH standard category</th>
        <th>Normalized values</th>
    </tr>
    <tr>
    <tr>
        <td><b>Gender</b></td>
        <td>
            <ul style="list-style-type:none">
                <li>male</li>
                <li>female</li>
                <li>other (i.e. missing, not on file)</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td><b>Alcohol_use</b></td>
        <td>
            <ul style="list-style-type:none">
                <li>yes</li>
                <li>no</li>
                <li>other</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td><b>Drug_status</b></td>
        <td>
            <ul style="list-style-type:none">
                <li>yes</li>
                <li>no</li>
                <li>other</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td><b>Tobacco_use</b></td>
        <td>
            <ul style="list-style-type:none">
                <li>yes</li>
                <li>no</li>
                <li>other</li>
            </ul>
        </td>
    </tr>  
    <tr>
        <td><b>Marital_status</b></td>
        <td>
            <ul style="list-style-type:none">
                <li>married_has_partner</li>
                <li>divorced</li>
                <li>single</li>
                <li>widow</li>
                <li>other</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td><b>Employment_status/Occupation</b></td>
        <td>
            <ul style="list-style-type:none">
                <li>employed</li>
                <li>unemployed</li>
                <li>retired_disabled</li>
                <li>other</li>
            </ul>
        </td>
    </tr>   
    <tr>
        <td><b>Financial_constraint</b></td>
        <td>
            <ul style="list-style-type:none">
                <li>has_financial_constraint</li>
                <li>no_financial_constraint</li>
                <li>other</li>
            </ul>
        </td>
    </tr> 
    <tr>
        <td><b>Living_condition</b></td>
        <td>
            <ul style="list-style-type:none">
                <li>homeless_shelter_unstable</li>
                <li>stable</li>
                <li>other</li>
            </ul>
        </td>
    </tr>    
    <tr>
        <td><b>Living_supply</b></td>
        <td>
            <ul style="list-style-type:none">
                <li>well_developed</li>
                <li>poorly_developed</li>
                <li>other</li>
            </ul>
        </td>
    </tr>  
    <tr>
        <td><b>Education</b></td>
        <td>
            <ul style="list-style-type:none">
                <li>college_or_above</li>
                <li>high_school_or_lower</li>
                <li>other</li>
            </ul>
        </td>
    </tr>   
    <tr>
        <td><b>Social_cohesion</b></td>
        <td>
            <ul style="list-style-type:none">
                <li>yes</li>
                <li>no</li>
                <li>other</li>
            </ul>
        </td>
    </tr>   
    <tr>
        <td><b>Abuse</b></td>
        <td>
            <ul style="list-style-type:none">
                <li>abuse</li>
                <li>no_abuse</li>
                <li>other</li>
            </ul>
        </td>
    </tr>  
    <tr>
        <td><b>Ethnicity</b></td>
        <td>
            <ul style="list-style-type:none">
                <li>hispanic</li>
                <li>not_hispanic</li>
                <li>other</li>
            </ul>
        </td>
    </tr> 
    <tr>
        <td><b>Sexual_activity</b></td>
        <td>
            <ul style="list-style-type:none">
                <li>active</li>
                <li>not_active</li>
                <li>other</li>
            </ul>
        </td>
    </tr>   
    <tr>
        <td><b>Physical_activity</b></td>
        <td>
            <ul style="list-style-type:none">
                <li>physically_active</li>
                <li>not_active</li>
                <li>other</li>
            </ul>
        </td>
    </tr>    
</table>

