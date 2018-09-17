# == Schema Information
#
# Table name: drive_places
#
#  id           :bigint(8)        not null, primary key
#  code         :string(255)      not null
#  section_type :string(255)
#  name         :string(255)
#  lat          :float(24)        default(0.0), not null
#  lon          :float(24)        default(0.0), not null
#  prefecture   :string(255)
#  city         :string(255)
#  postal_code  :string(255)
#  address      :string(255)      not null
#  tel          :string(255)
#  extra_infos  :text(65535)
#  options      :text(65535)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Drive::Place < Drive::Base
  serialize :options, JSON
  serialize :extra_infos, JSON

  def self.import_sheets!
    oauth = GoogleOauth2Client.oauth2_client(refresh_token: ENV.fetch("GOOGLE_REFRESH_TOKEN", ""))
    session = GoogleDrive::Session.from_credentials(oauth)
    spread_sheet = session.file_by_title("basic_infomation_of_local_govornments")
    self.import_from_formatted_spread_sheet!(spread_sheet: spread_sheet)
  end

  def self.import_from_formatted_spread_sheet!(spread_sheet:)
    worksheets = spread_sheet.worksheets
    worksheets.each do |worksheet|
      sheet_cells = worksheet.cells
      rowcolumn = sheet_cells.keys
      data_rowcolumn_lines = rowcolumn.select{|row, column| row >= 11 }.group_by{|row, column| row }
      places = []
      data_rowcolumn_lines.each do |row, rowcolumns|
        rows, columns = rowcolumns.transpose
        places << Drive::Place.new(
          code: sheet_cells[[row, columns[0]]],
          section_type: sheet_cells[[row, columns[1]]],
          name: sheet_cells[[row, columns[2]]],
          prefecture: sheet_cells[[row, columns[3]]],
          city: sheet_cells[[row, columns[4]]],
          postal_code: sheet_cells[[row, columns[6]]],
          address: sheet_cells[[row, columns[7]]],
          tel: sheet_cells[[row, columns[8]]],
          extra_infos: {
            furigana: sheet_cells[[row, columns[5]]],
            district: sheet_cells[[row, columns[9]]],
            area: sheet_cells[[row, columns[10]]],
            population: sheet_cells[[row, columns[11]]],
            population_trend: sheet_cells[[row, columns[12]]],
            change_rate_of_population: sheet_cells[[row, columns[13]]],
            avg_of_family_size: sheet_cells[[row, columns[14]]],
            kouikirengo: sheet_cells[[row, columns[15]]],
            wikipedia: sheet_cells[[row, columns[16]]],
            code56: sheet_cells[[row, columns[17]]],
            code5: sheet_cells[[row, columns[18]]],
            pppaaa: sheet_cells[[row, columns[19]]]
          }
        )
      end
      Drive::Place.import!(places)
    end
  end
end
