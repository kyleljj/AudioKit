//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ---
//:
//: ## Band Pass Filter
//: ### Band-pass filters allow audio above a specified frequency range and bandwidth to pass through to an output. The center frequency is the starting point from where the frequency limit is set. Adjusting the bandwidth sets how far out above and below the center frequency the frequency band should be. Anything above that band should pass through.
import XCPlayground
import AudioKit

let bundle = NSBundle.mainBundle()
let file = bundle.pathForResource("mixloop", ofType: "wav")
var player = AKAudioPlayer(file!)
player.looping = true

//: Next, we'll connect the audio sources to a band pass filter
var bandPassFilter = AKBandPassFilter(player)

//: Set the parameters of the band pass filter here
bandPassFilter.centerFrequency = 5000 // Hz
bandPassFilter.bandwidth = 600  // Cents

AudioKit.output = bandPassFilter
AudioKit.start()

//: User Interface Set up

class PlaygroundView: AKPlaygroundView {
    
    //: UI Elements we'll need to be able to access
    var centerFrequencyLabel: Label?
    var bandwidthLabel: Label?
    
    override func setup() {
        addTitle("Band Pass Filter")
        
        addLabel("Audio Player")
        addButton("Start", action: "start")
        addButton("Stop", action: "stop")
        
        addLabel("Band Pass Filter Parameters")
        
        addButton("Process", action: "process")
        addButton("Bypass", action: "bypass")
        
        centerFrequencyLabel = addLabel("Center Frequency: 5000 Hz")
        addSlider("setCenterFrequency:", value: 5000, minimum: 20, maximum: 22050)
        
        bandwidthLabel = addLabel("Bandwidth 600 Cents")
        addSlider("setBandwidth:", value: 600, minimum: 100, maximum: 12000)
    }
    
    //: Handle UI Events
    
    func start() {
        player.play()
    }
    
    func stop() {
        player.stop()
    }
    
    func process() {
        bandPassFilter.play()
    }
    
    func bypass() {
        bandPassFilter.bypass()
    }
    
    func setCenterFrequency(slider: Slider) {
        bandPassFilter.centerFrequency = Double(slider.value)
        let frequency = String(format: "%0.1f", bandPassFilter.centerFrequency)
        centerFrequencyLabel!.text = "Center Frequency: \(frequency) Hz"
    }
    
    func setBandwidth(slider: Slider) {
        bandPassFilter.bandwidth = Double(slider.value)
        let bandwidth = String(format: "%0.1f", bandPassFilter.bandwidth)
        bandwidthLabel!.text = "Bandwidth: \(bandwidth) Cents"
    }
}


let view = PlaygroundView(frame: CGRectMake(0, 0, 500, 550));
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
XCPlaygroundPage.currentPage.liveView = view

//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)
