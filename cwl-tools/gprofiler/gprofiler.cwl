cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["bash"]
label: gprofiler
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.Params)
  DockerRequirement:
    dockerPull: spctools/tpp:version6.3.3

$namespaces:
  edam: http://edamontology.org/

intent:
  - http://edamontology.org/operation_3664
inputs:
  Params:
    type: File
    inputBinding:
      position: 1
    default:
      class: File
      location: https://raw.githubusercontent.com/Workflomics/tools-and-domains/main/cwl-tools/gprofiler/gProfiler.sh
  gProfiler_in_1:
    type: File
    format: edam:format_2330  # Textual format
    edam:data_0006: edam:data_2872  # ID list
    doc: "Input file containing gene/query data"
    inputBinding:
      position: 2
outputs:
  gProfiler_out_1:
    type: File
    doc: "Output file containing the result of the curl command"
    format: edam:format_3464  # JSON
    edam:data_0006: edam:data_3753  # Over-representation data
    outputBinding:
      glob: "output.json"
