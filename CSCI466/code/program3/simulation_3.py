'''
Created on Oct 12, 2016

@author: mwitt_000
'''
import link_3
import network_3
import threading
from time import sleep

##configuration parameters


router_queue_size = 0 #0 means unlimited
simulation_time = 40 #give the network sufficient time to transfer all packets before quitting

if __name__ == '__main__':
    object_L = [] #keeps track of objects, so we can kill their threads

    #create network nodes    These are changed to correspond with the files for part 2 of the assignment
    #DL: New hosts added with more specific addresses to them for routing tables
    host_1 = network_3.Host(1271)
    host_2 = network_3.Host(1272)
    host_3 = network_3.Host(1291)
    host_4 = network_3.Host(1292)
    #DL: Adding the new hosts to the object list
    object_L.append(host_1)
    object_L.append(host_2)
    object_L.append(host_3)
    object_L.append(host_4)

    #DL: Setting up the 4 router network
    router_a = network_3.Router(name='A', intf_count=2, max_queue_size=router_queue_size)
    router_b = network_3.Router(name='B', intf_count=1, max_queue_size=router_queue_size)
    router_c = network_3.Router(name='C', intf_count=1, max_queue_size=router_queue_size)
    router_d = network_3.Router(name='D', intf_count=2, max_queue_size=router_queue_size)

    #DL: Adding the routing information to tables
    router_a.addToTable((1271,0))
    router_a.addToTable((1272,1))
    router_d.addToTable((0,1291))
    router_d.addToTable((1,1292))


    #DL: Adding them to the object list
    object_L.append(router_a)
    object_L.append(router_b)
    object_L.append(router_c)
    object_L.append(router_d)

    #create a Link Layer to keep track of links between network nodes   Changed to correspond with part 2 of the assignment
    link_layer = link_3.LinkLayer()
    object_L.append(link_layer)

    #add all the links
    #DL: the addresses of the hosts are edited to appropriate values tier 1
    link_layer.add_link(link_3.Link(host_1, 0, router_a, 0, 50))
    link_layer.add_link(link_3.Link(host_2, 0, router_a, 1, 50))
    #DL: tier 2
    link_layer.add_link(link_3.Link(router_a, 0, router_b, 0, 50))
    link_layer.add_link(link_3.Link(router_a, 1, router_c, 0, 50))
    #DL: tier 3
    link_layer.add_link(link_3.Link(router_b, 0, router_d, 0, 50))
    link_layer.add_link(link_3.Link(router_c, 0, router_d, 1, 50))
    #DL: tier 4
    link_layer.add_link(link_3.Link(router_d, 0, host_3, 0, 30))        #MTU change to 30 for part 2 of the assignment
    link_layer.add_link(link_3.Link(router_d, 1, host_4, 0, 30))        #MTU change to 30 for part 2 of the assignment
    #DL: the tiers are just following the verticle line of the picture provided where each jump is a tier.
    #DL: the received interface and the forwarding doesn't seem to matter. I think.

    #start all the objects
    thread_L = []
    thread_L.append(threading.Thread(name=host_1.__str__(), target=host_1.run))
    thread_L.append(threading.Thread(name=host_2.__str__(), target=host_2.run))
    thread_L.append(threading.Thread(name=host_3.__str__(), target=host_3.run))
    thread_L.append(threading.Thread(name=host_4.__str__(), target=host_4.run))
    thread_L.append(threading.Thread(name=router_a.__str__(), target=router_a.run))
    thread_L.append(threading.Thread(name=router_b.__str__(), target=router_b.run))
    thread_L.append(threading.Thread(name=router_c.__str__(), target=router_c.run))
    thread_L.append(threading.Thread(name=router_d.__str__(), target=router_d.run))

    thread_L.append(threading.Thread(name="Network", target=link_layer.run))

    for t in thread_L:
        t.start()


    #create some send events
    for i in range(1):  #DL: sending the two host's messages
        host_1.udt_send(1291, 'Sample data for host 3 from host 1', link_layer.link_L[1].in_intf.mtu)
        sleep(10)
        print("____________")
        print("__Seperate__")##DL: For more clear seperation
        print("____________")
        host_1.udt_send(1292, 'Sample data for host 4 from host 1', link_layer.link_L[1].in_intf.mtu)
        sleep(10)
        print("____________")
        print("__Seperate__")
        print("____________")
        host_2.udt_send(1291, 'Sample data for host 3 from host 2', link_layer.link_L[1].in_intf.mtu)
        sleep(10)
        print("____________")
        print("__Seperate__")
        print("____________")
        host_2.udt_send(1292, 'Sample data for host 4 from host 2', link_layer.link_L[1].in_intf.mtu)


    #give the network sufficient time to transfer all packets before quitting
    sleep(simulation_time)

    #join all threads
    for o in object_L:
        o.stop = True
    for t in thread_L:
        t.join()

    print("All simulation threads joined")
