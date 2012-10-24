require "sinatra"

require "helper/contract_manager"
require "helper/command_executer"
require "helper/output_parser"

post "/contract" do
  response_json = '{"pass":"false","data":{}}'
  output = "Contract Name is either nil or not valid."
  if !params[:contract_name].nil? && ContractManger.contract_loaded? && ContractManger.is_valid_contract?(params[:contract_name])
    command = ContractManger.get_execution_attribute("command",params[:contract_name])
    dir = ContractManger.get_execution_attribute("dir",params[:contract_name])
    output = CommandExecuter.execute_command(command,dir)
    response_json = OutputParser.parse_taas_output(output)
  end
   "<TaaS-Server-Response><Taas-Output>#{output}</TaaS-Output><TaaS-Json>#{response_json}</TaaS-Json></TaaS-Server-Response>"
end