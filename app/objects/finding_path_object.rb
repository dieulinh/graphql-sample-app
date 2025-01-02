class FindingPathObject
  attr_reader :finding_path

  def initialize(finding_path)
    @finding_path = finding_path
    @pq = PQueue.new
  end

  def to_s
    finding_path.join(' -> ')
  end
  def shortest_path
    @pq.push([finding_path.first, 0])
    dijkstra
  end
end