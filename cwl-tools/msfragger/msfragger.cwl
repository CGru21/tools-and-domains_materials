cwlVersion: v1.2
class: CommandLineTool
baseCommand: msfragger
label: msfragger
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.MSFragger_in_1)
      - $(inputs.MSFragger_in_2)
      - $(inputs.Params)
  DockerRequirement:
    dockerPull: spctools/tpp
    dockerOutputDirectory: /data
arguments:
  - valueFrom: "-Pcomet.params"
    position: 1
    shellQuote: false

$namespaces:
  edam: http://edamontology.org/

intent:
  - http://edamontology.org/operation_2421  # Database search
  - http://edamontology.org/operation_3801  # Spectral library search
  
inputs:
  Params:
    type: File
    default:
      class: File
      location: https://raw.githubusercontent.com/Workflomics/tools-and-domains/main/cwl-tools/msfragger/fragger.params
  MSFragger_in_1:
    type: File
    format: edam:format_3244  # mzML
    edam:data_0006: edam:data_0943  # Mass spectrum
    inputBinding:
      position: 3
      valueFrom: $(self.basename)
  MSFragger_in_2:
    type: File
    format: edam:format_1929  # FASTA
    edam:data_0006: edam:data_2976  # Protein sequence
    inputBinding:
      position: 2
      prefix: -D
      separate: false
      valueFrom: $(self.basename)


outputs:
    MSFragger_out_1: 
      type: File
      format: edam:format_3655  # pepXML
      edam:data_0006: edam:data_0945  # Peptide identification
      outputBinding:
        glob: "*.mzid"


      
