# app/admin/golf_courses.rb

ActiveAdmin.register GolfCourse do
  permit_params :name, :holes, :location, :picture

  index do
    selectable_column
    id_column
    column :name
    column :holes
    column :location
    column :picture do |golf_course|
      if golf_course.picture.attached?
        image_tag url_for(golf_course.picture), size: "100x100"
      end
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :holes
      f.input :location
      f.input :picture, as: :file
    end
    f.actions
  end

  filter :name
  filter :holes
  filter :location
end
