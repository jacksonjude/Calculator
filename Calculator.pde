import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.Arrays;
import java.math.BigDecimal;
import java.math.RoundingMode;

public static final int boxMargin = 15;
public static final int boxHeight = 150;
public static final int numRows = 4;
public static final int buttonMargin = 10;
public static final int buttonTextShift = 7;

public static final int backgroundColor = 150;
public static final int boxColor = 190;
public static final int numpadButtonDefaultColor = 255;
public static final int numpadButtonHoverColor = 210;
public static final int numpadButtonPressedColor = 180;

public static final String CLEAR_CODE = "AC";
public static final String DELETE_CODE = "DEL";
public static final String DECIMAL_CODE = ".";
public static final String ADDITION_CODE = "+";
public static final String SUBTRACTION_CODE = "–";
public static final String MUTLIPLICATION_CODE = "×";
public static final String DIVISION_CODE = "÷";
public static final String EXPONENT_CODE = "^";
public static final String OPEN_PAREN_CODE = "(";
public static final String CLOSE_PAREN_CODE = ")";
public static final String EQUALS_CODE = "=";

public static final int DECIMAL_PLACES = 1000;
public static final int REPETITIONS_REQUIRED = 3;
public static final int DISPLAY_DECIMAL_PLACES = 12;

public ArrayList<Button> numpadButtons;
public ArrayList<Button> operationButtons;

public final String[] operationButtonCodes = new String[]{DIVISION_CODE, EXPONENT_CODE, MUTLIPLICATION_CODE, OPEN_PAREN_CODE, SUBTRACTION_CODE, CLOSE_PAREN_CODE, ADDITION_CODE, EQUALS_CODE};

public String calculatorEntry = "";
public String calculatedResult = "";
public BigDecimal decimalResult;

public ArrayList<Integer> keyCodesPressed = new ArrayList<Integer>();

public boolean shouldPrintDevLogs = true;

public void setup()
{
  size(425,500);
}

public boolean shouldRedraw = true;

public void draw()
{
  if (shouldRedraw)
  {
    background(backgroundColor);
    drawCalculatorElements();
    shouldRedraw = false;
  }
}

public void mousePressed()
{
  for (Button numpadButton : numpadButtons)
  {
    if (numpadButton.isButtonClick(mouseX, mouseY))
    {
      numpadButton.setPressed(true);
    }
  }

  for (Button operationButton : operationButtons)
  {
    if (operationButton.isButtonClick(mouseX, mouseY))
    {
      operationButton.setPressed(true);
    }
  }
}

public void mouseReleased()
{
  for (Button numpadButton : numpadButtons)
  {
    if (numpadButton.getPressed())
    {
      numpadButton.setPressed(false);
      handleNumpadPress(numpadButton.getValue());
    }
  }

  for (Button operationButton : operationButtons)
  {
    if (operationButton.getPressed())
    {
      operationButton.setPressed(false);
      handleOperationPress(operationButton.getValue());
    }
  }
}

public void mouseMoved()
{
  for (Button numpadButton : numpadButtons)
  {
    if (numpadButton.isButtonClick(mouseX, mouseY))
    {
      numpadButton.setHover(true);
    }
    else
    {
      numpadButton.setHover(false);
    }
  }

  for (Button operationButton : operationButtons)
  {
    if (operationButton.isButtonClick(mouseX, mouseY))
    {
      operationButton.setHover(true);
    }
    else
    {
      operationButton.setHover(false);
    }
  }
}

public void keyPressed()
{
  handleKeyPressed(keyCode);
}

public void handleKeyPressed(int keyCodePressed)
{
  if (keyCodePressed == 16)
    keyCodesPressed.add(16);

  if (keyCodesPressed.contains(16))
  {
    switch (keyCodePressed)
    {
      case 48+0:
      getButtonForValue(CLOSE_PAREN_CODE).setPressed(true);
      keyCodesPressed.add(948+0);
      break;

      case 48+6:
      getButtonForValue(EXPONENT_CODE).setPressed(true);
      keyCodesPressed.add(948+6);
      break;

      case 48+8:
      getButtonForValue(MUTLIPLICATION_CODE).setPressed(true);
      keyCodesPressed.add(948+8);
      break;

      case 48+9:
      getButtonForValue(OPEN_PAREN_CODE).setPressed(true);
      keyCodesPressed.add(948+9);
      break;

      case 61:
      getButtonForValue(ADDITION_CODE).setPressed(true);
      keyCodesPressed.add(961);
      break;
    }
  }
  else
  {
    keyCodesPressed.add(keyCodePressed);
    switch (keyCodePressed)
    {
      case ENTER:
      case RETURN:
      case 61:
      getButtonForValue(EQUALS_CODE).setPressed(true);
      break;

      case 48+0:
      getButtonForValue("0").setPressed(true);
      break;

      case 48+1:
      getButtonForValue("1").setPressed(true);
      break;

      case 48+2:
      getButtonForValue("2").setPressed(true);
      break;

      case 48+3:
      getButtonForValue("3").setPressed(true);
      break;

      case 48+4:
      getButtonForValue("4").setPressed(true);
      break;

      case 48+5:
      getButtonForValue("5").setPressed(true);
      break;

      case 48+6:
      getButtonForValue("6").setPressed(true);
      break;

      case 48+7:
      getButtonForValue("7").setPressed(true);
      break;

      case 48+8:
      getButtonForValue("8").setPressed(true);
      break;

      case 48+9:
      getButtonForValue("9").setPressed(true);
      break;

      case 45:
      getButtonForValue(SUBTRACTION_CODE).setPressed(true);
      break;

      case 47:
      getButtonForValue(DIVISION_CODE).setPressed(true);
      break;

      case 46:
      getButtonForValue(DECIMAL_CODE).setPressed(true);
      break;

      case 8:
      getButtonForValue(DELETE_CODE).setPressed(true);
      break;

      case 192:
      shouldPrintDevLogs = false;
      //simulationData = new int[9];
      simulateRandomKeyPresses(80, 0);
      shouldPrintDevLogs = true;
      break;
    }
  }
}

public void keyReleased()
{
  handleKeyReleased(keyCode);
}

public void handleKeyReleased(int keyCodeReleased)
{
  if (keyCodeReleased == 16)
    keyCodesPressed.remove(keyCodesPressed.indexOf(16));

  if (keyCodesPressed.contains(16) || keyCodesPressed.contains(keyCodeReleased+900))
  {
    switch (keyCodeReleased)
    {
      case 48+0:
      getButtonForValue(CLOSE_PAREN_CODE).setPressed(false);
      handleOperationPress(CLOSE_PAREN_CODE);
      break;

      case 48+6:
      getButtonForValue(EXPONENT_CODE).setPressed(false);
      handleOperationPress(EXPONENT_CODE);
      break;

      case 48+8:
      getButtonForValue(MUTLIPLICATION_CODE).setPressed(false);
      handleOperationPress(MUTLIPLICATION_CODE);
      break;

      case 48+9:
      getButtonForValue(OPEN_PAREN_CODE).setPressed(false);
      handleOperationPress(OPEN_PAREN_CODE);
      break;

      case 61:
      getButtonForValue(ADDITION_CODE).setPressed(false);
      handleOperationPress(ADDITION_CODE);
      break;

      case 8:
      handleNumpadPress(CLEAR_CODE);
      break;
    }

    if (keyCodesPressed.indexOf(900+keyCodeReleased) != -1)
      keyCodesPressed.remove(keyCodesPressed.indexOf(900+keyCodeReleased));
  }
  else
  {
    switch (keyCodeReleased)
    {
      case ENTER:
      case RETURN:
      case 61:
      getButtonForValue(EQUALS_CODE).setPressed(false);
      executeBaseCalculation();
      break;

      case 48+0:
      getButtonForValue("0").setPressed(false);
      handleNumpadPress("0");
      break;

      case 48+1:
      getButtonForValue("1").setPressed(false);
      handleNumpadPress("1");
      break;

      case 48+2:
      getButtonForValue("2").setPressed(false);
      handleNumpadPress("2");
      break;

      case 48+3:
      getButtonForValue("3").setPressed(false);
      handleNumpadPress("3");
      break;

      case 48+4:
      getButtonForValue("4").setPressed(false);
      handleNumpadPress("4");
      break;

      case 48+5:
      getButtonForValue("5").setPressed(false);
      handleNumpadPress("5");
      break;

      case 48+6:
      getButtonForValue("6").setPressed(false);
      handleNumpadPress("6");
      break;

      case 48+7:
      getButtonForValue("7").setPressed(false);
      handleNumpadPress("7");
      break;

      case 48+8:
      getButtonForValue("8").setPressed(false);
      handleNumpadPress("8");
      break;

      case 48+9:
      getButtonForValue("9").setPressed(false);
      handleNumpadPress("9");
      break;

      case 45:
      getButtonForValue(SUBTRACTION_CODE).setPressed(false);
      handleOperationPress(SUBTRACTION_CODE);
      break;

      case 47:
      getButtonForValue(DIVISION_CODE).setPressed(false);
      handleOperationPress(DIVISION_CODE);
      break;

      case 46:
      getButtonForValue(DECIMAL_CODE).setPressed(false);
      handleNumpadPress(DECIMAL_CODE);
      break;

      case 8:
      getButtonForValue(DELETE_CODE).setPressed(false);
      handleNumpadPress(DELETE_CODE);
      break;
    }

    if (keyCodesPressed.indexOf(keyCodeReleased) != -1)
      keyCodesPressed.remove(keyCodesPressed.indexOf(keyCodeReleased));
  }
}

public Button getButtonForValue(String value)
{
  ArrayList<Button> allButtons = new ArrayList<Button>();
  allButtons.addAll(numpadButtons);
  allButtons.addAll(operationButtons);

  for (Button button : allButtons)
    if (value.equals(button.getValue()))
      return button;

  return allButtons.get(0);
}

public void drawCalculatorElements()
{
  drawEntryBox();

  int rowHeight = (height-(boxMargin+boxMargin*2+boxHeight)-buttonMargin*(numRows-1)-buttonMargin*2)/numRows;
  drawNumpad(rowHeight);
  drawOperationsBox(rowHeight);
}

public void drawEntryBox()
{
  fill(boxColor);
  rect(boxMargin, boxMargin, width-boxMargin*2, boxHeight);

  fill(20);
  textAlign(LEFT);
  textSize(20);
  text(calculatorEntry + (calculatedResult == "" ? "" : "\n=" + calculatedResult), boxMargin*2, boxMargin*2, width-boxMargin*4, boxHeight-boxMargin);
}

public void drawNumpad(int buttonSize)
{
  final int buttonRows = 4;
  final int buttonColumns = 3;
  final String[] buttonTitles = new String[]{"7", "8", "9", "4", "5", "6", "1", "2", "3", "0", DECIMAL_CODE, DELETE_CODE};

  numpadButtons = new ArrayList<Button>();

  final int numpadWidth = (buttonColumns+1)*buttonMargin+buttonColumns*buttonSize;
  final int numpadHeight = (buttonRows+1)*buttonMargin+buttonRows*buttonSize;
  fill(boxColor);
  rect(boxMargin, boxMargin*2+boxHeight, numpadWidth, numpadHeight);

  for (int i=0; i < buttonRows; i++)
  {
    for (int j=0; j < buttonColumns; j++)
    {
      numpadButtons.add(new Button(buttonTitles[i*buttonColumns+j], buttonSize, boxMargin+(j+1)*buttonMargin+j*buttonSize+buttonSize/2, boxMargin*2+boxHeight+(i+1)*buttonMargin+i*buttonSize+buttonSize/2));
    }
  }

  for (Button numpadButton : numpadButtons)
  {
    numpadButton.show();
  }
}

public void handleNumpadPress(String numpadValue)
{
  String previousCharacter = null;
  if (calculatorEntry.length() > 0)
    previousCharacter = String.valueOf(calculatorEntry.charAt(calculatorEntry.length()-1));

  if (numpadValue.matches("-?\\d+") || numpadValue.equals(DECIMAL_CODE))
  {
    if (calculatorEntry.length() > 0 && previousCharacter.equals(CLOSE_PAREN_CODE))
      calculatorEntry += MUTLIPLICATION_CODE;

    boolean didAddZeroBeforeDecimal = false;
    if (numpadValue.equals(DECIMAL_CODE) && (calculatorEntry.length() == 0 || Arrays.asList(operationButtonCodes).contains(previousCharacter)))
    {
      calculatorEntry += "0";
      didAddZeroBeforeDecimal = true;
    }
    calculatorEntry += numpadValue;

    if (numpadValue.equals(DECIMAL_CODE))
    {
      ArrayList<String> numericalValues = getNumericalValues(calculatorEntry);
      if (!isNumeric(numericalValues.get(numericalValues.size()-1)))
        calculatorEntry = calculatorEntry.substring(0, calculatorEntry.length()-(didAddZeroBeforeDecimal ? 2 : 1));
    }
  }
  else if (numpadValue.equals(DELETE_CODE) && calculatorEntry.length() > 0)
    calculatorEntry = calculatorEntry.substring(0, calculatorEntry.length()-1);
  else if (numpadValue.equals(CLEAR_CODE))
    calculatorEntry = "";

  calculatedResult = "";

  drawEntryBox();
}

public static boolean isNumeric(String str)
{
  try
  {
    Double.parseDouble(str);
    return true;
  }
  catch(NumberFormatException e)
  {
    return false;
  }
}

public void drawOperationsBox(int buttonSize)
{
  final int buttonRows = 4;
  final int buttonColumns = 2;
  final String[] buttonTitles = operationButtonCodes;

  operationButtons = new ArrayList<Button>();

  final int numpadWidth = (buttonColumns+1)*buttonMargin+buttonColumns*buttonSize;
  final int numpadHeight = (buttonRows+1)*buttonMargin+buttonRows*buttonSize;
  fill(boxColor);
  rect(width-(boxMargin+buttonMargin*(buttonColumns+1)+buttonSize*buttonColumns), boxMargin*2+boxHeight, numpadWidth, numpadHeight);

  for (int i=0; i < buttonRows; i++)
    for (int j=0; j < buttonColumns; j++)
      operationButtons.add(new Button(buttonTitles[i*buttonColumns+j], buttonSize, width-(boxMargin+((buttonColumns-1-j)+1)*buttonMargin+(buttonColumns-1-j)*buttonSize+buttonSize/2), boxMargin*2+boxHeight+(i+1)*buttonMargin+i*buttonSize+buttonSize/2));

  for (Button operationButton : operationButtons)
    operationButton.show();
}

public void handleOperationPress(String operationValue)
{
  calculatedResult = "";

  String previousCharacter = null;
  if (calculatorEntry.length() > 0)
    previousCharacter = String.valueOf(calculatorEntry.charAt(calculatorEntry.length()-1));

  if (operationValue.equals(EQUALS_CODE))
    executeBaseCalculation();
  else if (operationValue.equals(SUBTRACTION_CODE) && (calculatorEntry.length() == 0 || (!previousCharacter.equals("-")) && Arrays.asList(operationButtonCodes).contains(previousCharacter) && !previousCharacter.equals(OPEN_PAREN_CODE) && !previousCharacter.equals(CLOSE_PAREN_CODE)))
  {
    calculatorEntry += "-";
    drawEntryBox();
  }
  else if (((operationValue.equals(OPEN_PAREN_CODE) && (calculatorEntry.length() == 0 || !previousCharacter.equals("-"))) || operationValue.equals(CLOSE_PAREN_CODE)) || (calculatorEntry.length() > 0 && ((previousCharacter.equals(CLOSE_PAREN_CODE) || (!Arrays.asList(operationButtonCodes).contains(previousCharacter) && !previousCharacter.equals("-"))))))
  {
    if (operationValue.equals(OPEN_PAREN_CODE) && calculatorEntry.length() > 0 && (previousCharacter.matches("[-\\d\\" + DECIMAL_CODE + "EIN]+") || previousCharacter.equals(CLOSE_PAREN_CODE)))
      calculatorEntry += MUTLIPLICATION_CODE;
    else if (operationValue.equals(CLOSE_PAREN_CODE) && calculatorEntry.length() > 0 && (previousCharacter.equals(OPEN_PAREN_CODE) || previousCharacter.equals("-")))
      calculatorEntry += "0";
    calculatorEntry += operationValue;
    drawEntryBox();
  }
}

public void executeBaseCalculation()
{
  if (calculatorEntry.equals("")) return;

  if (calculatedResult.equals("") || !calculatedResult.contains(DECIMAL_CODE))
  {
    String formattedCalculatorEntry = checkParentheses(calculatorEntry);
    calculatedResult = formatNumberAsString(executeCalculation(formattedCalculatorEntry));

    if (calculatedResult.equals("")) return;

    if (calculatedResult.startsWith("0E") || calculatedResult.startsWith("-0E")) //Fix 0E-150 problem
      calculatedResult = "0";

    if (!(calculatedResult.contains("Infinity") || calculatedResult.contains("NaN")))
      decimalResult = new BigDecimal(calculatedResult);

    if (calculatedResult.contains(DECIMAL_CODE) && !calculatedResult.contains("E") && calculatedResult.split("\\" + DECIMAL_CODE)[1].length() > DISPLAY_DECIMAL_PLACES)
      calculatedResult = calculatedResult.split("\\" + DECIMAL_CODE)[0] + DECIMAL_CODE + calculatedResult.split("\\" + DECIMAL_CODE)[1].substring(0, DISPLAY_DECIMAL_PLACES);

    if (calculatedResult.endsWith(DECIMAL_CODE + "0"))
      calculatedResult = calculatedResult.replace(DECIMAL_CODE + "0", "");
  }
  else if (calculatedResult.contains(DECIMAL_CODE) || decimalResult != null)
  {
    String fractionResult = getFractionalResult(decimalResult.toString());
    if (!fractionResult.equals(""))
      calculatedResult = fractionResult;
  }

  if (shouldPrintDevLogs)
    println("-", calculatedResult);

  drawEntryBox();
}

public String checkParentheses(String calculation)
{
  int openParenCount = 0;
  int closeParenCount = 0;

  for (int i=0; i < calculation.length(); i++)
  {
    String calculationCharacter = String.valueOf(calculation.charAt(i));
    if (calculationCharacter.equals(OPEN_PAREN_CODE)) openParenCount++;
    if (calculationCharacter.equals(CLOSE_PAREN_CODE)) closeParenCount++;

    if (closeParenCount > openParenCount)
    {
      calculation = OPEN_PAREN_CODE + calculation;
      openParenCount++;
      i++;
    }
  }

  while (openParenCount > closeParenCount)
  {
    calculation += CLOSE_PAREN_CODE;
    closeParenCount++;
  }
  while (openParenCount < closeParenCount)
  {
    calculation = OPEN_PAREN_CODE + calculation;
    openParenCount++;
  }

  calculation = calculation.replace("()", "(0)");

  return calculation;
}

public String executeCalculation(String calculation)
{
  String lastCharacter = null;
  if (calculation.length() > 0)
    lastCharacter = String.valueOf(calculation.charAt(calculation.length()-1));

  if (calculation.length() > 0 && ((Arrays.asList(operationButtonCodes).contains(lastCharacter) || lastCharacter.equals("-")) && !lastCharacter.equals(OPEN_PAREN_CODE) && !lastCharacter.equals(CLOSE_PAREN_CODE)))
  {
    String secondToLastCharacter = null;
    if (calculation.length() >= 2)
      secondToLastCharacter = String.valueOf(calculation.charAt(calculation.length()-2));
    if (lastCharacter.equals("-") && calculatorEntry.length() >= 2 && Arrays.asList(operationButtonCodes).contains(secondToLastCharacter) && !lastCharacter.equals(OPEN_PAREN_CODE) && !lastCharacter.equals(CLOSE_PAREN_CODE))
      calculation = calculation.substring(0, calculation.length()-2);
    else
      calculation = calculation.substring(0, calculation.length()-1);
  }

  calculation = evaluateParentheses(calculation);
  calculation = performOperations(calculation, new String[]{EXPONENT_CODE});
  calculation = performOperations(calculation, new String[]{MUTLIPLICATION_CODE, DIVISION_CODE});
  calculation = performOperations(calculation, new String[]{ADDITION_CODE, SUBTRACTION_CODE});

  return calculation;
}

public String evaluateParentheses(String calculation)
{
  ArrayList<String> parentheticals = new ArrayList<String>();

  int parentheticalLevel = 0;
  int startOfCurrentParenthetical = 0;
  for (int i=0; i < calculation.length(); i++)
  {
    if (String.valueOf(calculation.charAt(i)).equals(OPEN_PAREN_CODE))
    {
      if (parentheticalLevel == 0) startOfCurrentParenthetical = i;
      parentheticalLevel++;
    }

    if (String.valueOf(calculation.charAt(i)).equals(CLOSE_PAREN_CODE))
    {
      parentheticalLevel--;
      if (parentheticalLevel == 0)
        parentheticals.add(calculation.substring(startOfCurrentParenthetical+1, i+1-1));
    }
  }

  for (String parenthetical : parentheticals)
    calculation = calculation.replaceFirst("\\(" + escapeRegex(parenthetical) + "\\)", executeCalculation(parenthetical));

  return calculation;
}

public String escapeRegex(String literal)
{
  return literal.replace(".", "\\" + DECIMAL_CODE).replace("+", "\\+").replace("*", "\\*").replace("^", "\\^").replace("(", "\\(").replace(")", "\\)");
}

public String performOperations(String calculation, String[] operationsToPerform)
{
  ArrayList<String> numericalValues = getNumericalValues(calculation);
  ArrayList<String> operations = getOperations(calculation);

  if (operations.size() == 0) return calculation;

  while (!Arrays.asList(operationsToPerform).contains(operations.get(0)))
  {
    operations.remove(0);
    numericalValues.remove(0);
    if (operations.size() == 0) return calculation;
  }

  calculation = formatNumberAsString(calculation);
  for (int i=0; i < numericalValues.size(); i++)
    if (numericalValues.get(i).contains("I"))
      numericalValues.set(i, numericalValues.get(i).replace("I", "Infinity"));
    else if (numericalValues.get(i).contains("N"))
      numericalValues.set(i, numericalValues.get(i).replace("N", "NaN"));

  String calculatedValue = "0";
  //println("NUM--", numericalValues.get(0), numericalValues.get(1), calculation);
  switch (operations.get(0))
  {
    case EXPONENT_CODE:
    calculatedValue = String.valueOf(Math.pow(Double.parseDouble(numericalValues.get(0)), Double.parseDouble(numericalValues.get(1))));
    break;

    case MUTLIPLICATION_CODE:
    if (numericalValues.get(0).contains("Infinity") || numericalValues.get(1).contains("Infinity") || numericalValues.get(0).contains("NaN") || numericalValues.get(1).contains("NaN"))
      calculatedValue = String.valueOf(Double.parseDouble(numericalValues.get(0))*Double.parseDouble(numericalValues.get(1)));
    else
      calculatedValue = (new BigDecimal(numericalValues.get(0))).multiply(new BigDecimal(numericalValues.get(1))).toString();
    break;

    case DIVISION_CODE:
    if (numericalValues.get(0).contains("Infinity") || numericalValues.get(1).contains("Infinity") || numericalValues.get(0).contains("NaN") || numericalValues.get(1).contains("NaN"))
      calculatedValue = String.valueOf(Double.parseDouble(numericalValues.get(0))/Double.parseDouble(numericalValues.get(1)));
    else
      calculatedValue = (!(Double.parseDouble(numericalValues.get(1)) == 0.0) ? (new BigDecimal(numericalValues.get(0))).divide(new BigDecimal(numericalValues.get(1)), DECIMAL_PLACES, RoundingMode.FLOOR).toString() : (Double.parseDouble(numericalValues.get(0)) == 0.0 ? "NaN" : "Infinity"));
    break;

    case ADDITION_CODE:
    if (numericalValues.get(0).contains("Infinity") || numericalValues.get(1).contains("Infinity") || numericalValues.get(0).contains("NaN") || numericalValues.get(1).contains("NaN"))
      calculatedValue = String.valueOf(Double.parseDouble(numericalValues.get(0))+Double.parseDouble(numericalValues.get(1)));
    else
      calculatedValue = (new BigDecimal(numericalValues.get(0))).add(new BigDecimal(numericalValues.get(1))).toString();
    break;

    case SUBTRACTION_CODE:
    if (numericalValues.get(0).contains("Infinity") || numericalValues.get(1).contains("Infinity") || numericalValues.get(0).contains("NaN") || numericalValues.get(1).contains("NaN"))
      calculatedValue = String.valueOf(Double.parseDouble(numericalValues.get(0))-Double.parseDouble(numericalValues.get(1)));
    else
      calculatedValue = (new BigDecimal(numericalValues.get(0))).subtract(new BigDecimal(numericalValues.get(1))).toString();
    break;
  }

  calculatedValue = calculatedValue.replace("+", "");

  String newCalculation = calculation.replaceFirst(escapeRegex(numericalValues.get(0) + operations.get(0) + numericalValues.get(1)), calculatedValue.toString());
  newCalculation = formatStringAsNumber(newCalculation);

  if (shouldPrintDevLogs)
    println("--", calculation, newCalculation);
  return performOperations(newCalculation, operationsToPerform);
}

public ArrayList<String> getNumericalValues(String calculation)
{
  ArrayList<String> numericalValues = new ArrayList<String>();

  Pattern pattern = Pattern.compile("([-\\d\\" + DECIMAL_CODE + "EIN]+)");
  Matcher matcher = pattern.matcher(calculation);
  while (matcher.find())
  {
    numericalValues.add(matcher.group());
  }

  return numericalValues;
}

public ArrayList<String> getOperations(String calculation)
{
  ArrayList<String> operations = new ArrayList<String>();

  Pattern pattern = Pattern.compile("([^-\\d\\" + DECIMAL_CODE + "EIN]+)");
  Matcher matcher = pattern.matcher(calculation);
  while (matcher.find())
  {
    operations.add(matcher.group());
  }

  return operations;
}

public String formatStringAsNumber(String number)
{
  return number.replace("Infinity", "I").replace("NaN", "N");
}

public String formatNumberAsString(String number)
{
  return number.replace("I", "Infinity").replace("N", "NaN");
}

public String getFractionalResult(String calculation)
{
  //642857142857
  String decimalPattern = findRepeatingDecimalPattern(calculation, REPETITIONS_REQUIRED);
  if (decimalPattern == "") return "";
  String truncatedDecimal = getDecimalWithoutPattern(calculation, decimalPattern);
  if (truncatedDecimal == "") return "";

  int patternLength = decimalPattern.length();
  int decimalCalculationLength = (calculation.split("\\" + DECIMAL_CODE).length > 1 ? calculation.split("\\" + DECIMAL_CODE)[1].length() : 0);
  BigDecimal decimalCalculation = new BigDecimal(calculation);
  BigDecimal numeratorDecimal = decimalCalculation.multiply((new BigDecimal(10)).pow(patternLength)).subtract(decimalCalculation).setScale(decimalCalculationLength-patternLength-1, RoundingMode.HALF_UP);
  String numeratorString = String.valueOf(Double.parseDouble(DECIMAL_CODE + String.valueOf(numeratorDecimal).split("\\" + DECIMAL_CODE)[1]));

  // println("1--", decimalPattern, truncatedDecimal, patternLength, numeratorDecimal, numeratorString);
  // println("2--", decimalCalculation.multiply((new BigDecimal(10)).pow(patternLength)));
  // println("3--", decimalCalculation);

  int lengthOfNumeratorDecimal = (numeratorString.split("\\" + DECIMAL_CODE).length > 1 ? numeratorString.split("\\" + DECIMAL_CODE)[1].length() : 0);
  BigDecimal numerator = numeratorDecimal.multiply(new BigDecimal(10).pow(lengthOfNumeratorDecimal));
  BigDecimal denominator = ((new BigDecimal(10)).pow(patternLength)).subtract(new BigDecimal(1)).multiply(new BigDecimal(10).pow(lengthOfNumeratorDecimal));
  BigDecimal gcdFraction = gcd(numerator, denominator);

  return numerator.divide(gcdFraction).toString() + "/" + denominator.divide(gcdFraction).toString();
}

public BigDecimal gcd(BigDecimal a, BigDecimal b)
{
   if (b.compareTo(new BigDecimal(0.0)) == 0) return a;
   return gcd(b, a.remainder(b));
}

public String findRepeatingDecimalPattern(String calculation, int numberOfRepetitionsRequired)
{
  String patternString = "\\" + DECIMAL_CODE + "\\d*?(\\d+?)";
  for (int i=0; i < numberOfRepetitionsRequired; i++)
    patternString += "\\1";
  patternString += ".*";

  return getRegexGroup(calculation, patternString);
}

public String getDecimalWithoutPattern(String calculation, String decimalPattern)
{
  String patternString = "(.*\\" + DECIMAL_CODE + "\\d*?)" + decimalPattern + ".*";
  return getRegexGroup(calculation, patternString);
}

public String getRegexGroup(String testString, String patternString)
{
  Pattern pattern = Pattern.compile(patternString);
  Matcher matcher = pattern.matcher(testString);
  if (matcher.find())
    return matcher.group(1);
  return "";
}

public class Button
{
  private String value;
  private int size;
  private int xPos;
  private int yPos;
  private boolean isPressed = false;
  private boolean isHovering = false;

  public Button(String value, int size, int x, int y)
  {
    this.value = value;
    this.size = size;
    this.xPos = x;
    this.yPos = y;
  }

  public void show()
  {
    if (isPressed) fill(numpadButtonPressedColor);
    else if (isHovering) fill(numpadButtonHoverColor);
    else fill(numpadButtonDefaultColor);
    ellipse(xPos, yPos, size, size);
    textAlign(CENTER);
    textSize(20);
    fill(0);
    text(value, xPos, yPos+buttonTextShift);
  }

  public boolean isButtonClick(int x, int y)
  {
    return sqrt(pow((xPos-x),2)+pow((yPos-y),2)) <= size/2;
  }

  public boolean getPressed()
  {
    return isPressed;
  }

  public void setPressed(boolean pressed)
  {
    isPressed = pressed;
    show();
  }

  public void setHover(boolean hover)
  {
    if (isHovering == hover) return;
    isHovering = hover;
    show();
  }

  public String getValue()
  {
    return value;
  }
}

public int[] simulationData = new int[7];

public void simulateRandomKeyPresses(int repetitions, int simulationsRun)
{
  handleKeyPressed(16);
  handleKeyPressed(8);
  handleKeyReleased(8);
  handleKeyReleased(16);

  int[] randomKeys = new int[]{48+0, 48+1, 48+2, 48+3, 48+4, 48+5, 48+6, 48+7, 48+8, 48+9, 46, 54, 56, 57, 48, 45, 61, 47};
  for (int i=0; i < repetitions; i++)
  {
    int randomKeyIndex = (int) Math.floor(Math.random() * randomKeys.length);
    int randomKeyCode = randomKeys[randomKeyIndex];
    boolean shouldPressShift = false;

    if (randomKeyIndex >= 11 && randomKeyIndex != 15 && randomKeyIndex <= 16)
      shouldPressShift = true;

    if (shouldPressShift)
      handleKeyPressed(16);
    handleKeyPressed(randomKeyCode);
    handleKeyReleased(randomKeyCode);
    if (shouldPressShift)
      handleKeyReleased(16);
  }

  simulationsRun++;
  println(simulationsRun, calculatorEntry);

  handleKeyPressed(61);
  handleKeyReleased(61);

  //if (calculatedResult.equals("NaN") || calculatedResult.contains("Infinity") || calculatedResult.contains("2147483647") || calculatedResult.contains("2147483648") || calculatedResult.equals("0") || calculatedResult.equals("1") || calculatedResult.contains("E"))
  if (calculatedResult.equals("NaN"))
    simulationData[0] = simulationData[0]+1;
  else if (calculatedResult.contains("Infinity"))
    simulationData[1] = simulationData[1]+1;
  else if (calculatedResult.equals("0"))
    simulationData[2] = simulationData[2]+1;
  else if (calculatedResult.equals("1"))
    simulationData[3] = simulationData[3]+1;
  else if (calculatedResult.equals("-1"))
    simulationData[4] = simulationData[4]+1;
  else if (calculatedResult.contains("E"))
    simulationData[5] = simulationData[5]+1;
  else
    simulationData[6] = simulationData[6]+1;

  if (simulationsRun < 2000)
    simulateRandomKeyPresses(repetitions, simulationsRun);
  else
    println(simulationData);
}
