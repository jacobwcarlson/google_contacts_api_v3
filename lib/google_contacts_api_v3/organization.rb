# See https://developers.google.com/gdata/docs/2.0/elements#gdOrganization
# for details on what these field mean
module GoogleContactsApiV3
  require 'util'

  class Organization
    attr_accessor :label, :org_department, :org_job_description, :org_name
    attr_accessor :org_symbol, :org_title, :primary, :rel, :where, :type

    # The field names seem really redundant to me (with the org_ prefix)
    # so here are some aliases to unredundify.
    alias :department :org_department
    alias :job_description :org_job_description
    alias :name :org_name
    alias :symbol :org_symbol
    alias :title :org_title

    def self.create_from_json(json)
      Organization.new.tap do |organization|
        organization.label = json['label']
        organization.primary = json['primary'] == "true"
        organization.type = json['rel'].to_s.split("#").last
        organization.rel = json['rel']
        organization.org_department = json['gd$orgDepartment'].andand['$t']
        organization.org_job_description =
          json['gd$orgJobDescription'].andand['$t']
        organization.org_name = json['gd$orgName'].andand['$t']
        organization.org_symbol = json['gd$orgSymbol'].andand['$t']
        organization.org_title = json['gd$orgTitle'].andand['$t']
        organization.where = json['gd$where'].andand['$t']
      end.freeze
    end
  end # class Organization
end # module GoogleContactsApiV3

