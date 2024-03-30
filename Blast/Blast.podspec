Pod::Spec.new do |s|
  s.name           	= "Blast"
  s.version        	= "0.0.19"
  s.summary        	= "High-performance Swift framework to accelerate iOS app development with UIControllers for every view"
  s.license 	    = "MIT"
  s.description    	= "Blast is engineered to support rapid, yet stable, app construction in Swift. In the end, every viewcontroller needs a screen, and SwiftUI simply isn't ready yet. The UIKit controller is still the best viewcontroller for every view, and my previous framework Blaze has been used by many companies to create their Apps blazingly fast. Blast is the Swift version of Blaze, updated with a better structure and even better performance."
  s.homepage       	= "https://github.com/BobDG/Blast"
  s.authors        	= {"Bob de Graaf" => "graafict@gmail.com"}
  s.source         	= { :git => "https://github.com/BobDG/Blast.git", :tag => s.version.to_s }
  s.source_files   	= "Blast/**/*.{swift}"
  s.swift_version   = "5.0"
  s.platform       	= :ios, "14.0"
  s.requires_arc   	= true
  s.module_name 	= "Blast"
end
