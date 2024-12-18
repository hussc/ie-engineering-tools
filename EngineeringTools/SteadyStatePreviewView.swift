//
//  SteadyStatePreviewView.swift
//  QueueingModels
//
//  Created by Hussein ElRyalat on 11/12/24.
//

import SwiftUI

struct HorizontalTransitionDiagramView: View {
    let maxStates: Int
    let arrivalRate: Double
    let serviceRate: Double
    
    private let nodeSize: CGFloat = 70
    private let nodeSpacing: CGFloat = 20
    private let fontSize: CGFloat = 14
    
    private let nodeBackgroundColor = Color.backgroundPrimary.opacity(0.05)
    private let textColor = Color.backgroundPrimary
    private let transitionColor: Color = Color.backgroundPrimary.opacity(0.1)
    
    var body: some View {
        ScrollView(.horizontal) {
            Canvas { context, size in
                let startX: CGFloat = nodeSize
                let centerY: CGFloat = size.height / 2
                
                for i in 0..<maxStates {
                    // Draw node
                    let position = CGPoint(x: startX + CGFloat(i) * nodeSpacing + nodeSize * CGFloat(i), y: centerY)
                    drawNode(context: context, position: position, label: "\(i)")
                    
                    if i < maxStates - 1 {
                        // Draw transition arrow to the next state
                        let nextPosition = CGPoint(x: startX + CGFloat(i + 1) * nodeSpacing + nodeSize * CGFloat(i + 1), y: centerY)
                        drawCurvedArrow(context: context, from: position, to: nextPosition, arrivalRate: arrivalRate, serviceRate: serviceRate)
                    }
                }
            }
            .frame(height: 200)
            .frame(width: nodeSize * CGFloat(maxStates + 1) + nodeSpacing * CGFloat(maxStates))
        }
        .scrollIndicators(.hidden)
    }
    
    // MARK: - Drawing Functions
    
    private func drawNode(context: GraphicsContext, position: CGPoint, label: String) {
        // Draw the circle node
        let rect = CGRect(x: position.x - nodeSize / 2, y: position.y - nodeSize / 2, width: nodeSize, height: nodeSize)
        context.fill(Ellipse().path(in: rect), with: .color(nodeBackgroundColor))
        
        // Draw the label inside the node
        context.draw(Text(label).font(.system(size: fontSize, weight: .bold)).foregroundColor(textColor), at: position)
    }
    
    private func drawCurvedArrow(context: GraphicsContext, from: CGPoint, to: CGPoint, arrivalRate: Double, serviceRate: Double) {
        let lineWidth: CGFloat = 2
        let offsetFromNode: CGFloat = 10
        let halfNodeSize = nodeSize / 2
        
        let controlOffset: CGFloat = 75
        let lambdaControlPoint = CGPoint(x: (from.x + to.x) / 2, y: from.y - controlOffset)
        let lambdaStartPoint = CGPoint(
            x: from.x,
            y: from.y - halfNodeSize - offsetFromNode
        )
        
        let lambdaEndPoint = CGPoint(
            x: to.x,
            y: to.y - halfNodeSize - offsetFromNode
        )
        
        let lambdaPath = Path { path in
            path.move(to: lambdaStartPoint)
            path.addQuadCurve(to: lambdaEndPoint, control: lambdaControlPoint)
        }
        
        context.stroke(
            lambdaPath,
            with: .color(transitionColor),
            lineWidth: lineWidth
        )
        
        // Label λ on the arrow
        let lambdaPosition = CGPoint(
            x: (from.x + to.x) / 2,
            y: lambdaControlPoint.y
        )
        
        context.draw(Text("λ = \(arrivalRate, specifier: "%.2f")").font(.system(size: fontSize)).foregroundColor(textColor), at: lambdaPosition)

        let muControlPoint = CGPoint(x: (from.x + to.x) / 2, y: from.y + controlOffset)

        let muEndPoint = CGPoint(
            x: from.x,
            y: from.y + halfNodeSize + offsetFromNode
        )
        
        let muStartPoint = CGPoint(
            x: to.x,
            y: to.y + halfNodeSize + offsetFromNode
        )
        
        let muPath = Path { path in
            path.move(to: muStartPoint)
            path.addQuadCurve(to: muEndPoint, control: muControlPoint)
        }
        
        context.stroke(
            muPath,
            with: .color(transitionColor),
            lineWidth: lineWidth
        )
        
        // Label μ on the arrow
        let muPosition = CGPoint(x: (from.x + to.x) / 2, y: muControlPoint.y)
        context.draw(Text("μ = \(serviceRate, specifier: "%.1f")").font(.system(size: fontSize)).foregroundColor(textColor), at: muPosition)
    }
}
struct HorizontalTransitionDiagramView_Previews: PreviewProvider {
    static let attributes = QueueingSystemAttributes(
        systemLength: 4.5,
        queueingLength: 2.3,
        timeInSystem: 3.0,
        timeInQueue: 1.5,
        probabilityCalculation: ProbabilityCalculation(systemLimit: nil) { _ in 0.1 }
    )
    
    static var previews: some View {
        HorizontalTransitionDiagramView(
            maxStates: 100,
            arrivalRate: 2.0,
            serviceRate: 3.0
        )
        .frame(height: 200)
    }
}
