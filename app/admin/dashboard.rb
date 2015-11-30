ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => "Dashboard"

  content :title => "Dashboard" do
    panel "README" do
      para <<-PARA
First thing you need to do is add the providers that students will be able to select from.  All you need is name and email of each provider.  Click "Providers" along the top bar and use the "Add Provider" button.
      PARA
      para <<-PARA
Please do not delete any providers.  If you no longer want one to be selectable by students (cuz they got fired or something), then click "Edit" and check the "Disabled" box and "Update Provider".  Disabled providers are hidden by default so they don't clutter up your interface.
      PARA
      para <<-PARA
After providers are added, you can click "Students" at the top and "New Student".  Enter the student's name and email and click "Create Student", and they will be emailed with a link that lets them choose a provider to evaluate them.  They can use that link as many times as they want.  When they choose a provider, that provider is emailed a link that takes them to an evaluation form.
      PARA
      para <<-PARA
As soon as a student selects an evaluator, an evaluation is created.  You can see the status of the evaluations by clicking "Evaluations".
      PARA
      para <<-PARA
If any questions or issues come up, you have my email address.
      PARA
      para <<-PARA
--Mike
      PARA
    end

    panel "Previews" do
      para "Here you can preview what the forms look like"
      ul do
        li 'Sorry, this is broken at the moment.'
        # li link_to('Student form', student_new_evaluation_path('demo'))
        # li link_to('Evaluator form', provider_show_evaluation_path(access_code: 'demo', id: 'demo'))
      end
    end
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
