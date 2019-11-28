class RailsCom::MigrationAttributes
  attr_reader :record_class, :new_attributes, :custom_attributes, :new_references
  
  def initialize(record_class)
    @record_class = record_class
    @table_exists = record_class.table_exists?
    set_new_references
    set_new_attributes
    set_custom_attributes
  end
  
  def to_hash
    r = instance_values.slice('table_exists', 'new_references', 'new_attributes', 'custom_attributes')
    r.symbolize_keys!
  end

  def table_name
    @table_name = record_class.table_name
  end
  
  def set_new_references
    @new_references = record_class.reflections.values.select do |reflection|
      reflection.belongs_to? && !Account.column_names.include?(reflection.foreign_key)
    end

    @new_references.map! do |ref|
      r = { name: ref.name }
      r.merge! polymorphic: true if ref.polymorphic?
      r.merge! reference_options: reference_options(r)
    end
  end
  
  def set_new_attributes
    @new_attributes = record_class.new_attributes
    @new_attributes.map! do |attribute|
      attribute.merge! attribute_options: attribute_options(attribute)
    end
  end
  
  def set_custom_attributes
    if @table_exists
      @custom_attributes = record_class.custom_attributes
      @custom_attributes.map! do |attribute|
        attribute.merge! attribute_options: attribute_options(attribute)
      end
    else
      @custom_attributes = []
    end
  end
  
  def reference_options(reference)
    reference.slice(:polymorphic).inject('') { |s, h| s << ", #{h[0]}: #{h[1].inspect}" }
  end
  
  def attribute_options(attribute)
    attribute.slice(:limit, :precision, :scale, :comment, :default, :null, :index).inject('') { |s, h| s << ", #{h[0]}: #{h[1].inspect}" }
  end
  
end