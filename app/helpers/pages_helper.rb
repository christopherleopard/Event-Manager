module PagesHelper
    def gallery_images_1
        pattern = /\Agallery_1\/.*\.(png|jpe?g|gif|webp|svg)\z/i

        if Rails.application.config.assets.compile
        base = Rails.root.join("app/assets/images/gallery_1")
        Dir.glob(base.join("**/*"))
            .select { |f| File.file?(f) && f =~ /\.(png|jpe?g|gif|webp|svg)\z/i }
            .map { |f| Pathname(f).relative_path_from(Rails.root.join("app/assets/images")).to_s }
            .select { |p| p.match?(pattern) }
            .sort
        else
        manifest = Rails.application.assets_manifest
        manifest.assets.keys.grep(pattern).sort
        end
    end

    def gallery_images_2
        pattern = /\Agallery_2\/.*\.(png|jpe?g|gif|webp|svg)\z/i

        if Rails.application.config.assets.compile
        base = Rails.root.join("app/assets/images/gallery_2")
        Dir.glob(base.join("**/*"))
            .select { |f| File.file?(f) && f =~ /\.(png|jpe?g|gif|webp|svg)\z/i }
            .map { |f| Pathname(f).relative_path_from(Rails.root.join("app/assets/images")).to_s }
            .select { |p| p.match?(pattern) }
            .sort
        else
        manifest = Rails.application.assets_manifest
        manifest.assets.keys.grep(pattern).sort
        end
    end

    def gallery_images_3
        pattern = /\Agallery_3\/.*\.(png|jpe?g|gif|webp|svg)\z/i

        if Rails.application.config.assets.compile
        base = Rails.root.join("app/assets/images/gallery_3")
        Dir.glob(base.join("**/*"))
            .select { |f| File.file?(f) && f =~ /\.(png|jpe?g|gif|webp|svg)\z/i }
            .map { |f| Pathname(f).relative_path_from(Rails.root.join("app/assets/images")).to_s }
            .select { |p| p.match?(pattern) }
            .sort
        else
        manifest = Rails.application.assets_manifest
        manifest.assets.keys.grep(pattern).sort
        end
    end
end
