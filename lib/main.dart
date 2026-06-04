import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MaterialCalcuApp());
}

class MaterialCalcuApp extends StatelessWidget {
  const MaterialCalcuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Métodos Numéricos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TuPantallaDeCalculadora(), // Aquí pones el widget de tu calculadora
    );
  }
}


<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Calculadora Vectorial</title>
    <style>
        :root {
            color-scheme: light;
            --bg: #eef7ee;
            --panel: #f4fdf4;
            --panel-strong: #daf4d5;
            --text: #2f4d3a;
            --muted: #5f7b62;
            --accent: #b8debb;
            --accent-strong: #93c99b;
            --button: #f2faf3;
            --button-hover: #daf4dc;
            --button-secondary: #d6ead6;
            --button-secondary-hover: #b8d9bb;
            --danger: #c3e9c2;
            --shadow: 0 20px 40px rgba(93, 131, 98, 0.12);
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: 'Inter', system-ui, sans-serif;
            background: radial-gradient(circle at top left, #f3fbf2 0%, #dcf2d9 30%, #eef7ee 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 32px;
            color: var(--text);
        }

        .calculator {
            width: min(420px, 100%);
            background: linear-gradient(180deg, rgba(255, 255, 255, 0.95), rgba(255, 255, 255, 0.9));
            border: 1px solid rgba(255, 255, 255, 0.85);
            border-radius: 32px;
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .calculator__top {
            padding: 28px 26px 24px;
            background: radial-gradient(circle at top left, rgba(255, 255, 255, 0.96), rgba(247, 214, 235, 0.82));
            border-bottom: 1px solid rgba(255, 255, 255, 0.7);
        }

        .calculator__title {
            margin: 0 0 8px;
            font-size: 1.18rem;
            letter-spacing: 0.03em;
            color: var(--text);
        }

        .calculator__subtitle {
            margin: 0;
            font-size: 0.92rem;
            color: var(--muted);
        }

        .display {
            margin-top: 24px;
            border-radius: 28px;
            background: rgba(255, 255, 255, 0.82);
            padding: 22px 22px 18px;
            min-height: 122px;
            display: grid;
            gap: 12px;
            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, 0.65);
        }

        .display__expression {
            font-size: 0.95rem;
            color: var(--muted);
            word-break: break-all;
            min-height: 1.4em;
        }

        .display__result {
            font-size: clamp(2rem, 4vw, 3.4rem);
            line-height: 1.05;
            text-align: right;
            font-weight: 700;
            color: var(--text);
            min-height: 1.1em;
            word-break: break-all;
        }

        .keys {
            padding: 22px;
            display: grid;
            gap: 14px;
            grid-template-columns: repeat(4, minmax(72px, 1fr));
            background: #fff0fa;
        }

        .button {
            border: none;
            border-radius: 22px;
            padding: 20px 0;
            font-size: 1.05rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.15s ease, background-color 0.15s ease, box-shadow 0.15s ease;
            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, 0.55);
            color: var(--text);
            background: var(--button);
        }

        .button:hover {
            transform: translateY(-1px);
            background: var(--button-hover);
        }

        .button--accent {
            background: var(--accent);
            color: #3d2147;
        }

        .button--accent:hover {
            background: var(--accent-strong);
        }

        .button--secondary {
            background: var(--button-secondary);
        }

        .button--secondary:hover {
            background: var(--button-secondary-hover);
        }

        .button--wide {
            grid-column: span 2;
        }

        .button--danger {
            background: var(--danger);
            color: #4e2a40;
        }

        .button:focus-visible {
            outline: 3px solid rgba(184, 105, 156, 0.4);
            outline-offset: 2px;
        }

        .intro-screen {
            position: fixed;
            inset: 0;
            display: grid;
            place-items: center;
            background: rgba(245, 238, 248, 0.98);
            z-index: 20;
            padding: 24px;
        }

        .intro-card {
            width: min(560px, 100%);
            background: #ffffff;
            border-radius: 32px;
            box-shadow: var(--shadow);
            padding: 32px;
            text-align: center;
        }

        .intro-card h2 {
            margin: 0 0 16px;
            font-size: 1.8rem;
            color: var(--text);
        }

        .intro-card p {
            margin: 0 0 20px;
            color: var(--muted);
            font-size: 1rem;
        }

        .intro-list {
            list-style: none;
            padding: 0;
            margin: 0 0 24px;
            display: grid;
            gap: 10px;
        }

        .intro-item {
            background: #f7e3f1;
            border-radius: 18px;
            padding: 12px 16px;
            color: #4a2e51;
            font-weight: 600;
            box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.6);
        }
    </style>
</head>

<body>
    <div id="intro-screen" class="intro-screen">
        <div class="intro-card">
            <h2>Métodos disponibles</h2>
            <p>Primero revisa los métodos, luego abre la calculadora.</p>
            <ul class="intro-list">
                <li class="intro-item">Newton-Rapson</li>
                <li class="intro-item">Derivación</li>
                <li class="intro-item">Interpolación de Lagrange</li>
                <li class="intro-item">Simpson 1/3</li>
                <li class="intro-item">Simpson 3/4</li>
            </ul>
            <button id="intro-button" class="button button--accent" type="button">Abrir calculadora</button>
        </div>
    </div>
    <section class="calculator" aria-label="Calculadora Vectorial">
        <div class="calculator__top">
            <h1 class="calculator__title">Calculadora Vectorial</h1>
            <p class="calculator__subtitle">Operaciones exactas y diseño suave para tus cuentas.</p>
            <div class="display" aria-live="polite">
                <div id="expression" class="display__expression">0</div>
                <div id="result" class="display__result">0</div>
            </div>
        </div>
        <div class="keys">
            <button class="button button--secondary" type="button" data-action="clear">Limpiar</button>
            <button class="button button--secondary" type="button" data-action="delete">Borrar</button>
            <button class="button button--secondary" type="button" data-value="(">(</button>
            <button class="button button--secondary" type="button" data-value=")">)</button>

            <button class="button" type="button" data-value="7">7</button>
            <button class="button" type="button" data-value="8">8</button>
            <button class="button" type="button" data-value="9">9</button>
            <button class="button button--accent" type="button" data-value="/">÷</button>

            <button class="button" type="button" data-value="4">4</button>
            <button class="button" type="button" data-value="5">5</button>
            <button class="button" type="button" data-value="6">6</button>
            <button class="button button--accent" type="button" data-value="*">×</button>

            <button class="button" type="button" data-value="1">1</button>
            <button class="button" type="button" data-value="2">2</button>
            <button class="button" type="button" data-value="3">3</button>
            <button class="button button--accent" type="button" data-value="-">−</button>

            <button class="button button--wide" type="button" data-value="0">0</button>
            <button class="button" type="button" data-value=".">.</button>
            <button class="button button--accent" type="button" data-value="+">+</button>

            <button class="button button--danger button--wide" type="button" data-action="equals">Igual</button>
        </div>
    </section>

    <script>
        const expressionElement = document.getElementById('expression');
        const resultElement = document.getElementById('result');
        let expression = '';
        let justCalculated = false;
        let lastResult = '0';

        function updateDisplay() {
            expressionElement.textContent = expression || '0';
            resultElement.textContent = justCalculated ? lastResult : '0';
        }

        function appendValue(value) {
            if (justCalculated) {
                if (/^[0-9.]$/.test(value)) {
                    expression = value === '.' ? '0.' : value;
                } else if (/^[+\-*/]$/.test(value)) {
                    expression = lastResult + value;
                } else {
                    expression = value;
                }
                justCalculated = false;
            } else {
                if (expression === '0' && /^[0-9]$/.test(value)) {
                    expression = value;
                } else {
                    expression += value;
                }
            }
            updateDisplay();
        }

        function clearAll() {
            expression = '';
            lastResult = '0';
            justCalculated = false;
            updateDisplay();
        }

        function deleteLast() {
            if (justCalculated) {
                expression = lastResult;
                justCalculated = false;
            }
            expression = expression.slice(0, -1);
            updateDisplay();
        }

        function setError() {
            expressionElement.textContent = 'Error';
            resultElement.textContent = 'Revisa la operación';
            expression = '';
            justCalculated = false;
        }

        function calculate() {
            if (!expression.trim()) {
                lastResult = '0';
                justCalculated = true;
                updateDisplay();
                return;
            }

            try {
                const safeExpression = expression.replace(/[^0-9.+\-*/()]/g, '');
                const value = evaluateExpression(safeExpression);
                lastResult = value;
                justCalculated = true;
                resultElement.textContent = value;
                expressionElement.textContent = expression + ' =';
            } catch (error) {
                setError();
            }
        }

        function evaluateExpression(expr) {
            const tokens = tokenize(expr);
            const rpn = toRPN(tokens);
            return evaluateRPN(rpn);
        }

        function tokenize(expr) {
            const tokens = [];
            const cleaned = expr.replace(/\s+/g, '');
            let i = 0;

            while (i < cleaned.length) {
                const char = cleaned[i];

                if (char === '(' || char === ')') {
                    tokens.push({ type: 'paren', value: char });
                    i += 1;
                    continue;
                }

                if ('+-*/'.includes(char)) {
                    const prev = tokens[tokens.length - 1];
                    const isUnary = !prev || (prev.type === 'operator' && prev.value !== ')') || (prev.type === 'paren' && prev.value === '(');
                    if ((char === '+' || char === '-') && isUnary) {
                        let sign = char;
                        i += 1;
                        let number = '';
                        while (i < cleaned.length && /[0-9.]/.test(cleaned[i])) {
                            number += cleaned[i];
                            i += 1;
                        }
                        if (!number) {
                            tokens.push({ type: 'operator', value: char });
                        } else {
                            tokens.push({ type: 'number', value: normalizeNumber(sign + number) });
                        }
                        continue;
                    }
                    tokens.push({ type: 'operator', value: char });
                    i += 1;
                    continue;
                }

                if (/[0-9.]/.test(char)) {
                    let number = '';
                    while (i < cleaned.length && /[0-9.]/.test(cleaned[i])) {
                        number += cleaned[i];
                        i += 1;
                    }
                    tokens.push({ type: 'number', value: normalizeNumber(number) });
                    continue;
                }

                throw new Error('Token inválido');
            }

            return tokens;
        }

        function toRPN(tokens) {
            const output = [];
            const operators = [];
            const precedence = { '+': 1, '-': 1, '*': 2, '/': 2 };

            for (const token of tokens) {
                if (token.type === 'number') {
                    output.push(token);
                    continue;
                }

                if (token.type === 'operator') {
                    while (operators.length && operators[operators.length - 1].type === 'operator') {
                        const top = operators[operators.length - 1];
                        if (precedence[top.value] >= precedence[token.value]) {
                            output.push(operators.pop());
                            continue;
                        }
                        break;
                    }
                    operators.push(token);
                    continue;
                }

                if (token.type === 'paren') {
                    if (token.value === '(') {
                        operators.push(token);
                    } else {
                        while (operators.length && operators[operators.length - 1].value !== '(') {
                            output.push(operators.pop());
                        }
                        if (!operators.length || operators[operators.length - 1].value !== '(') {
                            throw new Error('Paréntesis desbalanceado');
                        }
                        operators.pop();
                    }
                }
            }

            while (operators.length) {
                const op = operators.pop();
                if (op.type === 'paren') {
                    throw new Error('Paréntesis desbalanceado');
                }
                output.push(op);
            }

            return output;
        }

        function evaluateRPN(rpn) {
            const stack = [];
            for (const token of rpn) {
                if (token.type === 'number') {
                    stack.push(token.value);
                    continue;
                }
                const b = stack.pop();
                const a = stack.pop();
                if (a === undefined || b === undefined) {
                    throw new Error('Expresión inválida');
                }
                const result = compute(a, b, token.value);
                stack.push(result);
            }
            if (stack.length !== 1) {
                throw new Error('Expresión inválida');
            }
            return stack[0];
        }

        function compute(a, b, operator) {
            switch (operator) {
                case '+': return add(a, b);
                case '-': return subtract(a, b);
                case '*': return multiply(a, b);
                case '/': return divide(a, b);
                default: throw new Error('Operador no válido');
            }
        }

        function normalizeNumber(value) {
            if (!value || value === '+' || value === '-') return '0';
            const negative = value.startsWith('-');
            const raw = value.replace(/^\+/, '');
            const cleaned = raw.replace(/^[-+]/, '');
            const parts = cleaned.split('.');
            const integerPart = parts[0].replace(/^0+(?=\d)|^$/, '') || '0';
            const decimalPart = parts[1] ? parts[1].replace(/0+$/, '') : '';
            let normalized = integerPart;
            if (decimalPart) {
                normalized += '.' + decimalPart;
            }
            if (normalized === '0' || normalized === '0.') normalized = '0';
            return negative && normalized !== '0' ? '-' + normalized : normalized;
        }

        function splitNumber(value) {
            const negative = value.startsWith('-');
            const clean = negative ? value.slice(1) : value;
            const [intPart, fracPart = ''] = clean.split('.');
            return { negative, intPart: intPart || '0', fracPart };
        }

        function formatDecimal(value) {
            if (value.includes('.')) {
                return value.replace(/\.0+$|0+$/, '').replace(/\.$/, '');
            }
            return value;
        }

        function add(a, b) {
            const aParts = splitNumber(a);
            const bParts = splitNumber(b);
            const scale = Math.max(aParts.fracPart.length, bParts.fracPart.length);
            const aInt = BigInt((aParts.intPart + aParts.fracPart.padEnd(scale, '')).replace(/^0+$/, '0')) * (aParts.negative ? -1n : 1n);
            const bInt = BigInt((bParts.intPart + bParts.fracPart.padEnd(scale, '')).replace(/^0+$/, '0')) * (bParts.negative ? -1n : 1n);
            const sum = aInt + bInt;
            return formatFixed(sum, scale);
        }

        function subtract(a, b) {
            const aParts = splitNumber(a);
            const bParts = splitNumber(b);
            const scale = Math.max(aParts.fracPart.length, bParts.fracPart.length);
            const aInt = BigInt((aParts.intPart + aParts.fracPart.padEnd(scale, '')) || '0') * (aParts.negative ? -1n : 1n);
            const bInt = BigInt((bParts.intPart + bParts.fracPart.padEnd(scale, '')) || '0') * (bParts.negative ? -1n : 1n);
            const diff = aInt - bInt;
            return formatFixed(diff, scale);
        }

        function multiply(a, b) {
            const aParts = splitNumber(a);
            const bParts = splitNumber(b);
            const aInt = BigInt(aParts.intPart + aParts.fracPart || '0');
            const bInt = BigInt(bParts.intPart + bParts.fracPart || '0');
            const scale = aParts.fracPart.length + bParts.fracPart.length;
            const product = aInt * bInt * (aParts.negative === bParts.negative ? 1n : -1n);
            return formatFixed(product, scale);
        }

        function divide(a, b) {
            const aParts = splitNumber(a);
            const bParts = splitNumber(b);
            const aInt = BigInt(aParts.intPart + aParts.fracPart || '0');
            const bInt = BigInt(bParts.intPart + bParts.fracPart || '0');
            if (bInt === 0n) {
                throw new Error('División por cero');
            }
            const numerator = aInt * 10n ** BigInt(bParts.fracPart.length + 20);
            const denominator = bInt * 10n ** BigInt(aParts.fracPart.length);
            const quotient = numerator / denominator;
            const integerPart = quotient / 10n ** 20n;
            let fractionPart = (quotient % 10n ** 20n).toString().padStart(20, '0');
            fractionPart = fractionPart.replace(/0+$/, '');
            const result = fractionPart ? `${integerPart.toString()}.${fractionPart}` : integerPart.toString();
            return aParts.negative !== bParts.negative && result !== '0' ? '-' + result : result;
        }

        function formatFixed(value, scale) {
            const negative = value < 0n;
            const absolute = negative ? -value : value;
            const base = absolute.toString().padStart(scale + 1, '0');
            const integerPart = base.slice(0, base.length - scale);
            const fractionPart = base.slice(base.length - scale).replace(/0+$/, '');
            const result = fractionPart ? `${integerPart}.${fractionPart}` : integerPart;
            return negative && result !== '0' ? '-' + result : result;
        }

        document.querySelectorAll('.button').forEach(button => {
            button.addEventListener('click', () => {
                const value = button.dataset.value;
                const action = button.dataset.action;

                if (action === 'clear') {
                    clearAll();
                    return;
                }

                if (action === 'delete') {
                    deleteLast();
                    return;
                }

                if (action === 'equals') {
                    calculate();
                    return;
                }

                if (value) {
                    appendValue(value);
                }
            });
        });

        const introScreen = document.getElementById('intro-screen');
        const introButton = document.getElementById('intro-button');
        if (introButton) {
            introButton.addEventListener('click', () => {
                introScreen.style.display = 'none';
                introScreen.hidden = true;
                clearAll();
            });
        }

        clearAll();
    </script>
</body>

</html>
