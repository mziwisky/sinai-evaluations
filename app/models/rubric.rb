class Rubric
  attr_reader :metrics

  def initialize(metrics = Rubric.current_metrics)
    @metrics = metrics.map { |m| Rubric::Metric.new(m.symbolize_keys) }
  end

  def apply_grades!(grades)
    grades ||= {}
    metrics_by_id = metrics.index_by(&:identifier).with_indifferent_access
    grades.each {|id, grade| metrics_by_id[id].grade = grade }
    mark_errors!
  end

  def metric_types
    metrics.map(&:type).uniq
  end

  def metrics_of_type(type)
    metrics.select {|m| m.type == type}
  end

  def completed?
    metrics.all?(&:graded?)
  end

  def mark_errors!
    metrics.each do |m|
      m.error = 'required' unless m.graded?
    end
  end

  def to_json
    metrics.map(&:to_hash).to_json
  end

  def self.options_for_metric_type(type)
    raise "unknown type: #{type}" unless OPTIONS_BY_TYPE.key?(type)
    OPTIONS_BY_TYPE[type]
  end

  # as soon as an Evaluation has an `evaluation`, then that defines its
  # metrics.  if its `evaluation` is blank, then the metrics are taken from the
  # Rubric.current_metrics
  def self.current_metrics
    [{
      title: 'Medical and Scientific Knowledge',
      description: "Describe the principles and methods of diagnostic decision-making (to include clinical, laboratory, pathologic and imaging studies. Describe the principles of therapeutic decision-making.",
      type: 'one_thru_five'
    },{
      title: 'Patient Care and Prevention',
      description: "Perform reliable (comprehensive and problem focused) history and physical examinations. Perform routine technical procedures.",
      type: 'one_thru_five'
    },{
      title: 'Professionalism and Self-awareness',
      description: "Demonstrate respect, dignity, compassion, and integrity when engaging patients, their families, peers, the university community, and other healthcare providers. Seek and respond appropriately to performance feedback.",
      type: 'one_thru_five'
    },{
      title: 'Practice Based, Life-Long Learning',
      description: "Search for, evaluate, and apply evidence-based medicine in the context of patient care. Develop the ability to self-assess and demonstrate a willingness to engage in reflective practice.",
      type: 'one_thru_five'
    },{
      title: 'Interpersonal Communication Skills',
      description: "Use effective listening, questioning, verbal, nonverbal, and writing skills when communicating with patients and their families. Use effective verbal presentation and written skills when communicating with colleagues, superiors, and other members of the healthcare team.",
      type: 'one_thru_five'
    },{
      title: 'Systems-Based, Interprofessional Practice',
      description: "Identify one's own role on the healthcare team and how it is complementary to other health professionals in the delivery of patient care. Recognize when and how to initiate the assistance of other healthcare providers in the context of patient care.",
      type: 'pass_fail'
    }]
  end

  private

  # NOTE: shouldn't ever edit these, only add new key-value pairs, cuz we don't
  # persist them, we only persist "type" strings
  OPTIONS_BY_TYPE = {
    'one_thru_five' => [
      {
        value: '1',
        desc: "Needs Remediation"
      },{
        value: '2',
        desc: "Developing Confidence"
      },{
        value: '3',
        desc: "Competent (target)"
      },{
        value: '4',
        desc: "Exceeds Competency Standards [Advanced M3]"
      },{
        value: '5',
        desc: "Exceeds Competency Standards [level of an Intern]"
      }
    ],

    'pass_fail' => [
      {
        value: 'fail',
        desc: 'Needs Remediation [Fail]'
      },{
        value: 'pass',
        desc: 'Competent or Exceeds Competency Standards [Pass]'
      }
    ]
  }

  class Metric
    attr_reader :title, :description, :type
    attr_accessor :grade, :error

    def initialize(title:, description:, type:, grade: nil)
      @title = title
      @description = description
      @type = type
      @grade = grade
    end

    def identifier
      # replace non-word characters (i.e. non-letters and non-numbers) w/ underscores
      # only one underscore per run of consecutive non-word chars
      # also prepend w/ `m_` to ensure it starts w/ a letter, not a number
      # and then symbolize that bitch
      ('m_' + title.downcase.gsub(/[\W_]+/, '_')).to_sym
    end

    def graded?
      self.grade.present?
    end

    def options
      Rubric.options_for_metric_type(type)
    end

    def to_hash
      %i[title description type grade].reduce({}) do |hash, attr|
        hash[attr] = send(attr)
        hash
      end
    end
  end
end
