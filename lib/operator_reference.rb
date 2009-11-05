module OperatorReference
  def to_operator(operator_code)
    klass = "Operator#{self.class.name}".constantize
    klass.find(:first, :conditions => {
      :operator_code => operator_code,
      :"#{self.class.name.underscore}_id" => self.id
    }).send( "#{self.class.name.underscore}_code" )
  end

end
