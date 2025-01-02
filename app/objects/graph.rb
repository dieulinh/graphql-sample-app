class Graph
  attr_accessor :nodes, :edges

  def initialize
    @nodes = []
    @edges = {}
  end

  def add_node(node)
    @nodes << node
    @edges[node] = {}
  end

  def add_edge(node1, node2, weight)
    @edges[node1] ||= {}
    @edges[node2] ||= {}
    @edges[node1][node2] = weight
    @edges[node2][node1] = weight
  end
  def dijkstra1(source)
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
   def dijkstra(source)
     distances = Hash.new(Float::INFINITY)
     previous_nodes = {}

     nodes = @edges.keys
     p_queue = nodes
     nodes.each do |node|
       distances[node] = Float::INFINITY
       previous_nodes[node] = nil
     end
     distances[source] = 0
     until p_queue.empty?
       current_node = p_queue.min_by { |node| distances[node] }
       @edges[current_node].each do |neighbor, w|

         exploring_distance = distances[current_node] + w
         if exploring_distance < distances[neighbor]
           distances[neighbor] = exploring_distance
           previous_nodes[neighbor] = current_node
         end



       end
       p_queue.delete(current_node)
     end
      return distances, previous_nodes


   end
  def dijkstra_with_destination(source, destination)
    distances = Hash.new(Float::INFINITY)
    previous_nodes = {}

    nodes = @edges.keys
    p_queue = nodes
    nodes.each do |node|
      distances[node] = Float::INFINITY
      previous_nodes[node] = nil
    end
    distances[source] = 0
    until p_queue.empty?
      current_node = p_queue.min_by { |node| distances[node] }
      @edges[current_node].each do |neighbor, w|

        exploring_distance = distances[current_node] + w

        if exploring_distance < distances[neighbor]
          distances[neighbor] = exploring_distance
          previous_nodes[neighbor] = current_node
        end
      end
      break if current_node == destination
      p_queue.delete(current_node)
    end
    return distances, previous_nodes
  end
  def app_caller

    add_edge('A', 'B', 4)
    add_edge('A', 'C', 1)
    add_edge('C', 'B', 2)
    add_edge('C', 'D', 5)
    add_edge('B', 'D', 1)
    add_edge('D', 'E', 3)
    add_edge('F', 'G', 5)
    dijkstra('A')
    puts dijkstra_with_destination('A', 'G')
  end
end