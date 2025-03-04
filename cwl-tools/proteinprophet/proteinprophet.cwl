cwlVersion: v1.2
class: CommandLineTool
baseCommand: "ProteinProphet"
label: proteinprophet
requirements:
  DockerRequirement:
    dockerPull: spctools/tpp:version6.3.3
  InitialWorkDirRequirement:
    listing:
      - $(inputs.ProteinProphet_in_2)
# We need to specify the positions of additional command line args,
# because PeptideProphet expects the input file as the first argument,
# and options/output filename as further arguments
arguments:
  - position: 2
    valueFrom: "output_proteinprophet.prot.xml"
  - position: 3
    valueFrom: "EXCELPEPS"

$namespaces:
  edam: http://edamontology.org/

intent:
  - http://edamontology.org/operation_3664
  - http://edamontology.org/operation_3767
  - http://edamontology.org/operation_3648
  - http://edamontology.org/operation_3644
  - http://edamontology.org/operation_3695
inputs:
  ProteinProphet_in_1:
    type: File
    format: edam:format_3655  # pepXML
    edam:data_0006: edam:data_0945  # Peptide identification
    inputBinding:
      position: 1
  ProteinProphet_in_2:
    type: File
    format: edam:format_1929  # FASTA
    edam:data_0006: edam:data_2976  # Protein sequence

outputs:
    ProteinProphet_out_1: 
      type: File
      format: edam:format_3747  # protXML
      edam:data_0006: edam:data_0945  # Peptide identification
      outputBinding:
        glob: "output_proteinprophet.prot.xml"
    ProteinProphet_out_2: 
      type: File
      format: edam:format_3475  # ProteinProphet promises xls, but actual output is TSV.
      edam:data_0006: edam:data_0945  # Peptide identification
      outputBinding:
        glob: "*.xls"


        

     