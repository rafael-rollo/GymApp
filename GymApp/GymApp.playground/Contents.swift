import Accelerate

/**
Linear interpolation doc's example
 https://developer.apple.com/documentation/accelerate/vdsp/3241011-linearinterpolate
 */

let result = vDSP.linearInterpolate(elementsOf: [100, 200, 300],
                                    using: [0, 0.5, 1, 1.5, 2])

// example to interpolate values from y scroll offset to the output shadow opacity value limited in 0.3
let contentOffset = 10.0 // of scrollView.contentOffset.y
let maxOffsetLimit = 20.0
let proportionalOffset = contentOffset / maxOffsetLimit

let minOpacity = 0.0
let maxOpacity = 0.3

let interpolatedValues = vDSP.linearInterpolate(
    elementsOf: [minOpacity, maxOpacity],
    using: [0, min(1, proportionalOffset), 1]
)

let opacity = interpolatedValues[1]
print(opacity)
