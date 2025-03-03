cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["xinteract", "-Noutput_interact.pep.xml" , "-p0.95" , "-l7" , "-PPM"]
label: peptideprophet
requirements:
  DockerRequirement:
    dockerPull: spctools/tpp:version6.3.3
  InitialWorkDirRequirement:
    listing:
      - $(inputs.PeptideProphet_in_1)
      - $(inputs.PeptideProphet_in_2)
      - $(inputs.PeptideProphet_in_3)

$namespaces:
  edam: http://edamontology.org/

intent:
  - http://edamontology.org/operation_3664
  - http://edamontology.org/operation_3675
  - http://edamontology.org/operation_3631
  - http://edamontology.org/operation_3649

inputs:
  PeptideProphet_in_1:  # 2021-10-8_Ecoli.pep.xml
    type: File
    format: edam:format_3655  # pepXML
    edam:data_0006: edam:data_0945  # Peptide identification
    inputBinding:
      position: 1
    #secondaryFiles:  # 2021-10-8_Ecoli.mzML
    #  - ^^.mzML
  PeptideProphet_in_2:
    type: File
    format: edam:format_3244  # mzML
    edam:data_0006: edam:data_0943
  PeptideProphet_in_3: 
    type: File
    format: edam:format_1929  # FASTA
    edam:data_0006: edam:data_2976  # Protein sequence
    inputBinding:
      position: 2
      prefix: -D
      separate: false
      valueFrom: $(self.basename)
outputs:  
    PeptideProphet_out_1: 
      type: File
      format: edam:format_3655  # pepXML
      edam:data_0006: edam:data_0945  # Peptide identification
      outputBinding:
        glob: "output_interact.pep.xml"
    PeptideProphet_out_2: 
      type: File
      format: edam:format_2331  # HTML
      edam:data_0006: edam:data_2048  # Report
      outputBinding:
        glob: "output_interact.pep-MODELS.html"


    