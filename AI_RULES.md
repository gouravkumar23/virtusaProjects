# AI Development Rules

## Tech Stack
- **Frontend Framework**: React with TypeScript for type-safe, component-based UI development.
- **Styling**: Tailwind CSS for utility-first styling and responsive design.
- **UI Components**: shadcn/ui for accessible, pre-built components.
- **Icons**: Lucide React for a consistent and clean iconography set.
- **Routing**: React Router for managing client-side navigation and page structure.
- **Backend/Scripts**: Python for data processing and fare calculation logic.
- **Logic/Services**: Java for core validation services and legacy business logic.
- **Database**: SQL (Oracle-compatible) for schema definitions and data persistence.

## Library Usage Rules
- **UI Components**: Always prioritize `shadcn/ui` components. Do not reinvent basic UI elements like buttons, inputs, or modals.
- **Icons**: Use `lucide-react` exclusively for all icons to maintain visual consistency.
- **Styling**: Use Tailwind CSS classes for all layouts and custom styling. Avoid writing raw CSS files unless absolutely necessary.
- **State Management**: Use React hooks (`useState`, `useContext`, `useReducer`) for local and global state.
- **Navigation**: Use `react-router-dom` for all internal linking and route management.
- **Code Structure**: 
    - Components should be stored in `src/components/` and kept under 100 lines.
    - Pages should be stored in `src/pages/`.
    - Logic shared between languages should be clearly documented in the `README.md`.