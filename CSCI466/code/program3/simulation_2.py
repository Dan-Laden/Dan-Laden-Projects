'''
Created on Oct 12, 2016

@author: mwitt_000
'''
import link_2
import network_2
import threading
from time import sleep

##configuration parameters


router_queue_size = 0 #0 means unlimited
simulation_time = 1 #give the network sufficient time to transfer all packets before quitting

if __name__ == '__main__':
    object_L = [] #keeps track of objects, so we can kill their threads
    
    #create network nodes    These are changed to correspond with the files for part 2 of the assignment
    client = network_2.Host(1)
    object_L.append(client)
    server = network_2.Host(2)
    object_L.append(server)
    router_a = network_2.Router(name='A', intf_count=1, max_queue_size=router_queue_size)
    object_L.append(router_a)
    
    #create a Link Layer to keep track of links between network nodes   Changed to correspond with part 2 of the assignment
    link_layer = link_2.LinkLayer()
    object_L.append(link_layer)
    
    #add all the links
    link_layer.add_link(link_2.Link(client, 0, router_a, 0, 50))
    link_layer.add_link(link_2.Link(router_a, 0, server, 0, 30))        #MTU change to 30 for part 2 of the assignment
    
    
    #start all the objects
    thread_L = []
    thread_L.append(threading.Thread(name=client.__str__(), target=client.run))
    thread_L.append(threading.Thread(name=server.__str__(), target=server.run))
    thread_L.append(threading.Thread(name=router_a.__str__(), target=router_a.run))
    
    thread_L.append(threading.Thread(name="Network", target=link_layer.run))
    
    for t in thread_L:
        t.start()
    
    
    #create some send events
    for i in range(1):  #just 1 event
        client.udt_send(2, 'Sample data, the great red fox jumped over the lazy brown dog and had a great time  %d' % i, link_layer.link_L[1].in_intf.mtu) #length of 86 chars this is the same transmission as part1
        #orig
        #client.udt_send(2, 'Sample data %d' % i, link_layer.link_L[1].in_intf.mtu)
    
    
    #give the network sufficient time to transfer all packets before quitting
    sleep(simulation_time)
    
    #join all threads
    for o in object_L:
        o.stop = True
    for t in thread_L:
        t.join()
        
    print("All simulation threads joined")



