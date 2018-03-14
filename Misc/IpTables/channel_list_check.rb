require 'json'

def check_service services
    return false if not services

    services.each do |s|
        if (['grabix', 'tvacr'].include? s['name'] and
            ['deployed', 'deploy_ready', 'existing_deploy_ready'].include? s['deploy_status'])
            return true
        end
    end

    false
end

def get_site machine_name
    m = /ENSWERCCR(\d)_.*/.match(machine_name)
    if '12345678'.include? m[1]
        return "Site #{m[1]}"
    end

    'others'
end

def init_machines
    machines = {
        'metadata' => {
            'machine_number' => 0
        }
    }
    1.upto(8) do |i|
        machines['metadata']["Site #{i}"] = 0
        machines["Site #{i}"] = {}
    end
    machines['others'] = {}
    machines['metadata']['others'] = 0

    machines
end

machines = init_machines
File.open('/tmp/globix-channel.json', 'r') do |sin|
    hash_data = JSON.parse sin.read
    hash_data.each do |server|
        if server['country'] == 'USA' && vms=server['virtual_machines']
            vms.each do |vm, spec|
                if check_service(spec['services'])
                    site = get_site vm
                    if not machines[site][vm]
                        machines[site][vm] = spec
                        machines['metadata']['machine_number'] += 1
                        machines['metadata'][site] += 1
                    end
                end
            end
        end
    end
end

puts "The machines list: \n#{machines['metadata']}"
tvacr_machine = 0
1.upto(8).each do |i|
    machines["Site #{i}"].each do |name, m|
    end
end


