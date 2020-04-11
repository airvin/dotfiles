// This workspace is functionally a combination of https://github.com/kkga/nibar
// and https://github.com/noperator/dotfiles/blob/master/widgets/spaces.coffee
import { css } from "uebersicht"

// https://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/
export const command = "/usr/local/bin/yabai -m query --spaces"

export const refreshFrequency = false

export const className = ` 
  -webkit-font-smoothing: antialiased;
  color: #FAFDFF;
  font: 14.3px 'Helvetica Neue';
  font-weight: bold;
  top: 3px;
  left: 10px;
  position: absolute;
`

const container = css`
    display: flex;
    flex-direction: row;
    padding: 3px 8px;
    justify-content: center;
`

const cell = css`
    margin: 0 0.5em;
    color: #aaa;
`

const visibleStyle = css`
    color: #fafdff;
    border-bottom: 2px solid #fafdff
`

export const render = ({ output }) => {
    const spaces = JSON.parse(output)
    return (
        <div className={container}>
            {renderSpaces(spaces)}
        </div>
    )
}

const renderSpaces = (spaces) => {
    let out = []
    const numDisplays = calcNumDisplays(spaces)

    for (let i = 1; i <= numDisplays; ++i) {
        let displaySpaces = generateSpacesForDisplay(spaces, i)
        out.push(displaySpaces)
        // add a "-" to separate spaces on different displays
        if (i < numDisplays) {
            out.push(<div className={cell}>—</div>)
        }
    }
    return out.flat()
}

const generateSpacesForDisplay = (spaces, displayNum) => {
    return spaces.filter(space => space.display == displayNum)
        .map(({index, visible, windows}) => {
            // what text to render for this space
            const value = windows.length > 0 ? ("" + index + "°") : index
            if (visible == 1) {
                return (<div className={`${cell} ${visibleStyle}`}>{value}</div>)
            }
            // default display
            return (<div className={cell}>{value}</div>)
        })
}

// each space contains a `"display": num` field, use it to cal num displays
const calcNumDisplays = (spaces) => {
    const set = new Set()
    spaces.forEach(space => {
        set.add(space.display)
    })
    return set.size
}

