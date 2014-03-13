require 'base64'
require 'sass'
require 'image_optim' #https://github.com/toy/image_optim

module Sass::Script::Functions
   def url64(image)
      assert_type image, :String

      #compute file/path/extention

      base_path ='../../../'# from the current directory /app/styles/sass/helpers
      root = File.expand_path(base_path, __FILE__)
      path = image.to_s[1, image.to_s.length-2]
      fullpath = File.expand_path(path, root)
      absname = File.expand_path(fullpath)
      ext = File.extname(path)

      #optimize image if it's a gif, jpg, png
      if ext.indx(%r{\.(?:gif|jpg|png)}) !=nil
        image_optim = ImageOptim.new(:pngcrush => false, :pngout => false, :advpng => {:level => 4}, :optipng => {:level => 7}, :jpegoptim => {:max_quality => 1 })
        #we can loose the ! and the method will save the image to a temp directory, otherwise it'll overwrite the original image
        image_optim.optimize_image!(fullpath)
      end

      #base64 encode the file
      file = File.open(fullpath, 'rb') #read mode & binary mode
      filesize = File.size(file) / 1000
      text = file.read
      file.close

      if filesize < 31
        text_b64 = Base64.encode64(text).gsub(/\r/,'').gsub(/\n/,'')
        contents = 'url(data:image/' + ext[1, ext.length-1] +';base64,' + text_b64 + ')'
      else
        contents = 'url(' + image.to_s + ')'
      end

      Sass::Script::String.new(contents)
   end
     declare :url64, :args => [:string]
end
