h1. This is the components of a monitoring system

Checks = Definition + Scheduling + Execution + Reporting
Checks follow the same pattern whether local or clustered

Status Archive = Receiving + Normalization + Change Alerting + Stale Alerting + Reporting

Notifications = Receiving + Silencing + Routing + Escalation + Delivery

Checks -> Status Archive -> Notifications

h2. Checks

checks need to allow for different ways for selecting targets for remote tests

h3. filesystem

use chef to deploy configs and restart the monitor

CONFIG_DIR/path/to/name.rb

every 300 do
  extend Capybara

  NAME = 'path.to.name'
end

every 60, 'other' do
  NAME = 'path.to.name.other'
end

h3. NATS clustered scheduling

cluster of command runners uses NAT and hashing to allocate jobs among clusters
uses chef to define environment requirements?

h3. local scheduling

everything runs locally

h3. reporting

initial reporting could just be an email, right?
later you could report it to lwes, nagios, or our Status Archive

h2. questions

how does monit checks fit in here?
make it easy to send metrics to graphite

h2. status archive

status
  value - required
  service - required
  host
  source
  scope

h3. dependencies

dependencies can be derived seperately via host and service ie. the host
has a dependencies on a switch port while the service has a dep on another service

h1. Logging

logstash is slow, complicated, and bloated. It should be 3 seperate things: shipper, processor, web interface.

The shipper and processor have many commonalities, but how to keep the agent thin is an important question. The
agent should use thor to implement it's commands

h1. Service management

graph of objects:

object
  source
  owner
  host
dependencies
  type

it should allow developers to attach anything they want, like fluiddb
