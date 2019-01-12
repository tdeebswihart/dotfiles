#!/usr/bin/ruby

require 'pdf-reader'
require 'pry'
require 'set'

ARGV.each do |filename|
  PDF::Reader.open(filename) do |reader|
    puts "# #{filename}"
    reader.pages.each do |page|
      seen = Set.new
      annots_ref = page.attributes[:Annots]
      annos = []
      if annots_ref
        actual_annots = Array(annots_ref).map { |a| reader.objects[a] }
        actual_annots.each do |actual_annot|
          actual_annot.each do |annot|
            annot = reader.objects.deref(annot)
            unless annot[:Contents].nil? or annot[:Contents] == "" or seen.include? annot[:Contents]
              seen.add annot[:Contents]
              annos << "- _#{annot[:Subtype]}_:\n  > #{annot[:Contents].encode('UTF-8', invalid: :replace, undef: :replace, replace: '').gsub('\n', '\n> ')}"
            end
          end
        end
        if annos.length > 0
          puts "## Page #{page.number}"
          puts annos.join("\n")
        end
      end
    end
  end
end
