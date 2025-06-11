cwlVersion: v1.2
label: Sage-proteomics
class: CommandLineTool
baseCommand: ["/bin/bash", "-c"]
arguments:
  - valueFrom: >
      "sage -o /data/output -f $(inputs.Sage_in_2.path) \
      $(inputs.Configuration.path) $(inputs.Sage_in_1.path) && \
      /data/sage_TSV_to_mzIdentML.sh /data/output/results.sage.tsv"
    shellQuote: false
requirements:
  ShellCommandRequirement: {}
  DockerRequirement:
    dockerPull: workflomics/sage:latest
    dockerOutputDirectory: /data
  InitialWorkDirRequirement:
    listing:
      - class: File
        location: sage_TSV_to_mzIdentML.sh
        basename: sage_TSV_to_mzIdentML.sh

$namespaces:
  edam: http://edamontology.org/

intent:
  - http://edamontology.org/operation_3631  # Peptide identification
  - http://edamontology.org/operation_3633  # Retention time prediction
  - http://edamontology.org/operation_2428  # Validation

inputs:
  Sage_in_1:
    type: File
    format: edam:format_3244  # mzML
    edam:data_0006: edam:data_0943  # Mass spectrum
  Sage_in_2:
    type: File
    format: edam:format_1929  # FASTA
    edam:data_0006: edam:data_2976  # Protein sequence

  Configuration:
    type: File
    format: edam:format_3464  # JSON
    default:
      class: File
      format: edam:format_3464  # JSON
      location: https://raw.githubusercontent.com/Workflomics/tools-and-domains/main/cwl-tools/Sage-proteomics/config.json

outputs:
  Sage_out_1:
    type: File
    format: edam:format_3247  # mzIdentML
    edam:data_0006: edam:data_0945  # Peptide identification
    outputBinding:
      glob: /data/output/results.sage.mzid
