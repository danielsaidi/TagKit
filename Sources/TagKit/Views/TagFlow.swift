//
//  TagFlow.swift
//  TagKit
//
//  Based on https://github.com/tevelee/SwiftUI-Flow
//
//  Created by Daniel Saidi on 2025-12-10.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This enum defines the supported tag flow types.
public enum TagFlow {

    case automatic

    /// A plain `ForEach`.
    case plain

    /// A horizontal flow with a custom configuration.
    case horizontal(Configuration)

    /// A vertical flow with a custom configuration.
    case vertical(Configuration)
}

public extension TagFlow {

    /// A horizontal flow with a standard configuration.
    static var horizontal: Self {
        horizontal(.standardHorizontal)
    }

    /// A vertical flow with a standard configuration.
    static var vertical: Self {
        vertical(.standardVertical)
    }
}

public extension EnvironmentValues {

    @Entry var tagFlow = TagFlow.automatic
}

public extension View {

    /// Apply a custom tag list flow.
    func tagFlow(
        _ flow: TagFlow
    ) -> some View {
        self.environment(\.tagFlow, flow)
    }
}

public extension TagFlow {

    /// This type can be used to configure a tag list flow.
    struct Configuration {

        /// Create a custom flow configuration.
        public init(
            horizontalAlignment: HorizontalAlignment,
            verticalAlignment: VerticalAlignment,
            horizontalSpacing: CGFloat? = nil,
            verticalSpacing: CGFloat? = nil,
            justified: Bool = false,
            distributeItemsEvenly: Bool = false
        ) {
            self.horizontalAlignment = horizontalAlignment
            self.verticalAlignment = verticalAlignment
            self.horizontalSpacing = horizontalSpacing
            self.verticalSpacing = verticalSpacing
            self.justified = justified
            self.distributeItemsEvenly = distributeItemsEvenly
        }

        public var horizontalAlignment: HorizontalAlignment
        public var verticalAlignment: VerticalAlignment
        public var horizontalSpacing: CGFloat?
        public var verticalSpacing: CGFloat?
        public var justified: Bool
        public var distributeItemsEvenly: Bool
    }
}

public extension TagFlow.Configuration {

    /// A standard horizontal flow configuration.
    static var standardHorizontal: Self {
        standardHorizontal()
    }

    /// A standard horizontal flow configuration.
    static func standardHorizontal(
        horizontalSpacing: CGFloat? = nil,
        verticalSpacing: CGFloat? = nil,
        justified: Bool = false,
        distributeItemsEvenly: Bool = false
    ) -> Self {
        .init(
            horizontalAlignment: .leading,
            verticalAlignment: .center
        )
    }

    /// A standard vertical flow configuration.
    static var standardVertical: Self {
        standardVertical()
    }

    /// A standard vertical flow configuration.
    static func standardVertical(
        horizontalSpacing: CGFloat? = nil,
        verticalSpacing: CGFloat? = nil,
        justified: Bool = false,
        distributeItemsEvenly: Bool = false
    ) -> Self {
        .init(
            horizontalAlignment: .center,
            verticalAlignment: .top
        )
    }
}
