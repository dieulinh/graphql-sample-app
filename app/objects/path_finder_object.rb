

class PathFinderObject
  def initialize
    @graph = Graph.new
  end

  def add_node(node)
    @graph.add_node(node)
  end
  def dijkstra(source)
    dist = {}
    previous = {}
    pq = PriorityQueue.new

    @nodes.each do |node|
      dist[node] = Float::INFINITY
      previous[node] = nil
      pq[node] = dist[node]
    end

    dist[source] = 0
    pq[source] = dist[source]

    until pq.empty?
      u = pq.delete_min_return_key

      @edges[u].each do |neighbor, weight|
        alt = dist[u] + weight
        if alt < dist[neighbor]
          dist[neighbor] = alt
          previous[neighbor] = u
          pq[neighbor] = alt
        end
      end
    end

    return dist, previous
  end
  def add_edge(node1, node2, weight)
    @graph.add_edge(node1, node2, weight)
  end

  def find_shortest_path(source)
    dist, prev = @graph.dijkstra(source)
    return dist, prev
  end
  def call
    add_node('A')
    add_node('B')
    add_node('C')
    add_node('D')
    add_node('E')

    add_edge('A', 'B', 4)
    add_edge('A', 'C', 1)
    add_edge('C', 'B', 2)
    add_edge('C', 'D', 5)
    add_edge('B', 'D', 1)
    add_edge('D', 'E', 3)
    add_edge('B', 'E', 8)

    dist, prev = find_shortest_path('A')

    puts "Distances from source A:"
    dist.each do |node, distance|
      puts "#{node}: #{distance}"
    end
    puts prev
  end
end


# # Example usage
# graph = Graph.new
# graph.add_node('A')
# graph.add_node('B')
# graph.add_node('C')
# graph.add_node('D')
# graph.add_node('E')
#
# graph.add_edge('A', 'B', 4)
# graph.add_edge('A', 'C', 1)
# graph.add_edge('C', 'B', 2)
# graph.add_edge('C', 'D', 5)
# graph.add_edge('B', 'D', 1)
# graph.add_edge('D', 'E', 3)
# graph.add_edge('B', 'E', 8)
#
# dist, prev = graph.dijkstra('A')
#
# puts "Distances from source A:"
# dist.each do |node, distance|
#   puts "#{node}: #{distance}"
# end
