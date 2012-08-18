# See https://developers.google.com/gdata/docs/2.0/elements#gdOrganization
# for details on what these field mean
module GoogleContactsApiV3
  require 'util'

  class Organization
    attr_reader :label, :org_department, :org_job_description, :org_name
    attr_reader :org_symbol, :org_title, :primary, :rel, :where

    # The field names seem really redundant to me (with the org_ prefix)
    # so here are some aliases to unredundify.
    alias :department :org_department
    alias :job_description :org_job_description
    alias :name :org_name
    alias :symbol :org_symbol
    alias :title :org_title
    alias :type :rel

    def initialize(args)
      @label = args[:label]
      @org_department = args[:org_department]
      @org_job_description = args[:org_job_description]
      @org_name = args[:org_name]
      @org_symbol = args[:org_symbol]
      @org_title = args[:org_title]
      @primary = args[:primary]
      @rel = args[:rel]
      @where = args[:where]
    end

    def self.create_from_json(json_map)
      return nil unless json_map

      Organization.new(:label => json_map['label'],
        :primary => json_map['primary'],
        :rel => json_map['rel'].to_s.split("#").last,
        :org_department => Util.get_text_val(json_map, 'gd$orgDepartment'),
        :org_job_description => Util.get_text_val(json_map, 'gd$orgJobDescription'),
        :org_name => Util.get_text_val(json_map, 'gd$orgName'),
        :org_symbol => Util.get_text_val(json_map, 'gd$orgSymbol'),
        :org_title => Util.get_text_val(json_map, 'gd$orgTitle'),
        :where => Util.get_text_val(json_map, 'gd$where'))
    end
  end # class Organization
end # module GoogleContactsApiV3

