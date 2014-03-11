ruleset examine_location{
	meta {
    name "Location Data"
    description <<
      Location Data
    >>
    author "Aaron"
    logging off
    use module location_data
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
  }
  dispatch {
  }
  global {
  }
  rule show_fs_location{
  select when web cloudAppSelected
  notify("hello","hi");
  }
}