# frozen_string_literal: true

# lib/tasks/import_data.rake

namespace :import do
  desc 'Import data from JSON to brands table'
  task brands: :environment do
    Brand.connection.execute('ALTER SEQUENCE brands_id_seq RESTART WITH 1')
    Brand.delete_all
    json_data = File.read('/home/hth/car_pj/db_json/brand.json')
    brands = JSON.parse(json_data)
    brands.each do |brand_data|
      Brand.create(brand_data)
    end
    puts 'Data imported successfully!'
  end

  desc 'Import data from JSON to segments table'
  task segments: :environment do
    Segment.connection.execute('ALTER SEQUENCE segments_id_seq RESTART WITH 1')
    Segment.delete_all
    json_data = File.read('/home/hth/car_pj/db_json/segment.json')
    segments = JSON.parse(json_data)
    segments.each do |segment_data|
      Segment.create(segment_data)
    end
    puts 'Data imported successfully!'
  end

  desc 'Import data from JSON to types table'
  task types: :environment do
    Type.connection.execute('ALTER SEQUENCE types_id_seq RESTART WITH 1')
    Type.delete_all
    json_data = File.read('/home/hth/car_pj/db_json/type.json')
    types = JSON.parse(json_data)
    types.each do |type_data|
      Type.create(type_data)
    end
    puts 'Data imported successfully!'
  end

  desc 'Import data from JSON to models table'
  task models: :environment do
    Model.connection.execute('ALTER SEQUENCE models_id_seq RESTART WITH 1')
    Model.delete_all
    json_data = File.read('/home/hth/car_pj/db_json/model.json')
    models = JSON.parse(json_data)
    models.each do |model_data|
      Model.create(model_data)
    end
    puts 'Data imported successfully!'
  end

  desc 'Clear existing data and import new data from JSON'

  task clear_and_import: :environment do
    # Clear existing data
    Brand.delete_all
    Segment.delete_all
    Type.delete_all
    Model.delete_all

    # Reset primary key sequences (if needed)

    # Import new data
    Rake::Task['import:brands'].invoke
    Rake::Task['import:segments'].invoke
    Rake::Task['import:types'].invoke
    Rake::Task['import:models'].invoke

    puts 'Data cleared and imported successfully!'
  end
end
